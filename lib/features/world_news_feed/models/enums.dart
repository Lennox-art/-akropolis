
enum NewsSourceEnum {
  bbcNews(
    id: "bbc-news",
    name: "BBC News",
    description:
    "Use BBC News for up-to-the-minute news, breaking news, video, audio and feature stories. BBC News provides trusted World and UK news as well as local and regional perspectives. Also entertainment, business, science, technology and health news.",
    url: "https://www.bbc.co.uk/news",
    category: "general",
    language: "en",
    country: "gb",
  ),
  cnn(
    id: "cnn",
    name: "CNN",
    description:
    "View the latest news and breaking news today for U.S., world, weather, entertainment, politics and health at CNN.",
    url: "http://us.cnn.com",
    category: "general",
    language: "en",
    country: "us",
  ),
  bloomberg(
    id: "bloomberg",
    name: "Bloomberg",
    description:
    "Bloomberg delivers business and markets news, data, analysis, and video to the world, featuring stories from Businessweek and Bloomberg News.",
    url: "http://www.bloomberg.com",
    category: "business",
    language: "en",
    country: "us",
  );

  final String id;
  final String name;
  final String description;
  final String url;
  final String category;
  final String language;
  final String country;

  const NewsSourceEnum({
    required this.id,
    required this.name,
    required this.description,
    required this.url,
    required this.category,
    required this.language,
    required this.country,
  });

  static Map<String,NewsSourceEnum> sourceMap = {for(var e in values) e.id : e};
}