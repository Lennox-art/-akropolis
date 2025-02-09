import * as logger from "firebase-functions/logger";
import * as functions from 'firebase-functions/v2';
import axios from "axios";
import { firestore } from "firebase-admin";



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
  publishedAt: Date;
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
  publishedAt: new Date(article.published_at), // Convert to Date object
});

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
