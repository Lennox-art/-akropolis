import * as logger from "firebase-functions/logger";
import * as functions from 'firebase-functions/v2';
import * as admin from "firebase-admin";
import axios from "axios";
import { firestore } from "firebase-admin";

// Ensure Firebase is initialized only once
if (admin.apps.length === 0) {
  admin.initializeApp();
}

// Post Reaction Model
export interface PostReaction {
  log: string[]; // Users who reacted with 'log'
  emp: string[]; // Users who reacted with 'emp'
}

// Post Comment Model
export interface PostComment {
  id: string;
  userId: string;
  postUrl: string;
  thumbnailUrl: string;
  replies: PostComment[];
  commentedAt: string; // Store as ISO string for compatibility
  reaction?: PostReaction;
}

// Author Model
interface Author {
  id: string;
  name: string;
  imageUrl?: string;
  type: string;
}

// NewsPost Model
interface NewsPost {
  id: string;
  thumbnailUrl: string;
  postUrl: string;
  title: string;
  description: string;
  author: Author;
  publishedAt: string;
  viewers: Array<string>; // Use Set to ensure unique viewers
  comments: PostComment[];
  reaction: PostReaction;
}

// Define article structure
interface Article {
  author?: string;
  title: string;
  description: string;
  url: string;
  source: string;
  image?: string;
  category: string;
  language: string;
  country: string;
  published_at: string;
}

// Define response structure
interface MediaStackResponse {
  pagination: {
    limit: number;
    offset: number;
    count: number;
    total: number;
  };
  data: Article[];
}

 type Indexable = {[key: string]: any};

 const cleanParams = (params: Record<string, any>) => {
  return Object.fromEntries(
    Object.entries(params).filter(([_, value]) => value !== undefined && value !== null && value !== "")
  );
};
// Ensure Firebase is initialized only once
const db = firestore();

const articleToNewsPost = (article: Article): NewsPost => ({
  id: generateTimestampId(), // Assuming a function to generate unique IDs
  thumbnailUrl: article.image || "", // Use an empty string if no image
  postUrl: article.url,
  title: article.title,
  description: article.description,
  author: {
    id: article.source,
    name: article.author || "Unknown",
    type: "publisher",
  },
  publishedAt: generateTimestamp(new Date(article.published_at)), // Convert to Date object
  viewers: [],
  comments: [],
  reaction: {
    log: [],
    emp: [],
  }, // Properly closed object
});

function generateTimestamp(now: Date): string {
  const isoString = now.toISOString(); // "2025-02-09T20:37:23.344Z"

  // Extract milliseconds and pad to six decimal places
  const millis = now.getMilliseconds().toString().padStart(3, "0"); // "344"
  const micros = millis + "359"; // Appending extra digits manually

  return isoString.replace(/\.\d{3}Z$/, `.${micros}Z`);
}

console.log(generateTimestamp(new Date()));
const generateTimestampId = (): string => {
  const now = process.hrtime.bigint(); // High-resolution time in nanoseconds
  return now.toString(); // Convert to string
};

export const fetchMediaStackArticles = functions.https.onRequest(async (request) => {

  const params: Indexable = cleanParams({ ...request.query });

  const {
    access_key,
    keywords,
    languages,
    countries,
    domains,
    exclude_domains,
    sources,
    date,
    limit,
    offset,
  } = params;


    if (!access_key) {
      //return response.status(400).json({ error: "access_key parameter is required" });
    }

    const qParams: Record<string, string | undefined> = {
      access_key,
      keywords,
      languages,
      countries: countries ? countries.split(",").join(",") : undefined,
      domains,
      exclude_domains,
      sources: sources ? sources.split(",").join(",") : undefined,
      date,
      limit,
      offset,
    };

    // ✅ Remove keys with undefined or "undefined"
    Object.keys(qParams).forEach((key) => {
      if (!qParams[key] || qParams[key] === "undefined") {
        delete qParams[key];
      }
    });

   const queryParams = new URLSearchParams(qParams as Record<string, string>).toString();

  logger.info(queryParams, {structuredData: true});


  const dataUrl = `http://api.mediastack.com/v1/news?${queryParams}`;
  console.log("Fetching from", dataUrl);
  try {
    const response = await axios.get<MediaStackResponse>(dataUrl);
    console.log("API Response:", response.data);


    const newsCollection = db.collection('news_posts');
    const batch = db.batch();

    // Commit batch operation
    response.data.data.forEach((article) => {
      const newsPost = articleToNewsPost(article); // Convert to NewsPost
      const docRef = newsCollection.doc(newsPost.id); // Reference to document
      batch.set(docRef, newsPost); // Add to batch operation
      logger.info(`Commited to ${article}`);
    });

    await batch.commit();

    logger.info("Commited to firestore");

  } catch (error: any) {
    if (axios.isAxiosError(error)) {
      console.error("Axios Error:", error.response?.data || error.message);
    } else {
      console.error("Unexpected Error:", error);
    }
  }

  //response.send("Hello from Firebase!");
});

// News API

// Add these new interfaces after your existing interfaces
interface NewsAPISource {
  id: string | null;
  name: string;
}

interface NewsAPIArticle {
  source: NewsAPISource;
  author: string | null;
  title: string;
  description: string;
  url: string;
  urlToImage: string | null;
  publishedAt: string;
  content: string;
}

interface NewsAPIResponse {
  status: string;
  totalResults: number;
  articles: NewsAPIArticle[];
}

// Add this conversion function after your existing articleToNewsPost function
const newsAPIArticleToNewsPost = (article: NewsAPIArticle): NewsPost => ({
  id: generateTimestampId(),
  thumbnailUrl: article.urlToImage || "",
  postUrl: article.url,
  title: article.title,
  description: article.description,
  author: {
    id: article.source.id || article.source.name,
    name: article.author || article.source.name,
    type: "publisher",
  },
  publishedAt: generateTimestamp(new Date(article.publishedAt)),
  viewers: [],
  comments: [],
  reaction: {
    log: [],
    emp: [],
  },
});

export const fetchNewsAPIHeadlines = functions.https.onRequest(async (request) => {
  const params: Record<string, any> = cleanParams({ ...request.query });

  const {
    apiKey,
    sources,
    country,
    category,
    language,
  } = params;

  if (!apiKey) {
    logger.error("API key is required");
    return;
  }

  const qParams: Record<string, string | undefined> = {
    apiKey,
    sources,
    country,
    category,
    language,
  };

  // Remove undefined parameters
  Object.keys(qParams).forEach((key) => {
    if (!qParams[key] || qParams[key] === "undefined") {
      delete qParams[key];
    }
  });

  const queryParams = new URLSearchParams(qParams as Record<string, string>).toString();
  const dataUrl = `https://newsapi.org/v2/top-headlines?${queryParams}`;
  console.log("Fetching from", dataUrl);
  console.log(queryParams, dataUrl);
  
  try {
    const response = await axios.get<NewsAPIResponse>(dataUrl);
    logger.info("Received response from NewsAPI", { structuredData: true });

    if (response.data.status !== "ok") {
      throw new Error(`NewsAPI returned status: ${response.data.status}`);
    }

    const newsCollection = db.collection('news_headlines');
    const batch = db.batch();

    response.data.articles.forEach((article) => {
      const newsPost = newsAPIArticleToNewsPost(article);
      const docRef = newsCollection.doc(newsPost.id);
      batch.set(docRef, newsPost);
      logger.info(`Added article to batch: ${article.title}`);
    });

    await batch.commit();
    logger.info(`Successfully committed ${response.data.articles.length} articles to Firestore`);

  } catch (error: any) {
    if (axios.isAxiosError(error)) {
      logger.error("NewsAPI request failed:", error.response?.data || error.message);
    } else {
      logger.error("Unexpected error:", error);
    }
  }
});


export const fetchWorldNewsNewsApi = functions.https.onRequest(async (request) => {
  const params: Record<string, any> = cleanParams({ ...request.query });

  const {
    apiKey,
    q,
    from,
    to,
    sources,
    country,
    sortBy,
    category,
    language,
    pageSize,
    page,
  } = params;

  if (!apiKey) {
    logger.error("API key is required");
    return;
  }

  const qParams: Record<string, string | undefined> = {
    apiKey,
    q,
    from,
    to,
    sources,
    country,
    sortBy,
    category,
    language,
    pageSize,
    page,
  };

  // Remove undefined parameters
  Object.keys(qParams).forEach((key) => {
    if (!qParams[key] || qParams[key] === "undefined") {
      delete qParams[key];
    }
  });

  const queryParams = new URLSearchParams(qParams as Record<string, string>).toString();
  const dataUrl = `https://newsapi.org/v2/everything?${queryParams}`;
  console.log("Fetching from", dataUrl);
  console.log(queryParams, dataUrl);
  
  try {
    const response = await axios.get<NewsAPIResponse>(dataUrl);
    logger.info("Received response from NewsAPI", { structuredData: true });

    if (response.data.status !== "ok") {
      throw new Error(`NewsAPI returned status: ${response.data.status}`);
    }

    const newsCollection = db.collection('world_news');
    const batch = db.batch();

    response.data.articles.forEach((article) => {
      const newsPost = newsAPIArticleToNewsPost(article);
      const docRef = newsCollection.doc(newsPost.id);
      batch.set(docRef, newsPost);
      logger.info(`Added article to batch: ${article.title}`);
    });

    await batch.commit();
    logger.info(`Successfully committed ${response.data.articles.length} articles to Firestore`);

  } catch (error: any) {
    if (axios.isAxiosError(error)) {
      logger.error("NewsAPI request failed:", error.response?.data || error.message);
    } else {
      logger.error("Unexpected error:", error);
    }
  }
});
// ... rest of your existing code ...