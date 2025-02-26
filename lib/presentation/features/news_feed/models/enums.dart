enum PostMenu {
  share("Share"),
  bookmark("Bookmark"),
  notInterested("Not interested"),
  report("Report");

  final String title;

  const PostMenu(this.title);
}

enum NewsSourceEnum {
  bbc(
    id: "bbc-news",
    title: "BBC News",
    description:
    "Use BBC News for up-to-the-minute news, breaking news, video, audio and feature stories. BBC News provides trusted World and UK news as well as local and regional perspectives. Also entertainment, business, science, technology and health news.",
    url: "https://www.bbc.co.uk/news",
    imageUrl: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.youtube.com%2Fchannel%2FUC16niRr50-MSBwiO3YDb3RA&psig=AOvVaw0mxOhbd6bur3eBokJiZTUK&ust=1738264949215000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCMj6hdnTm4sDFQAAAAAdAAAAABAE",
    category: "general",
    language: "en",
    country: "gb",
  ),
  cnn(
    id: "cnn",
    title: "CNN",
    description:
    "View the latest news and breaking news today for U.S., world, weather, entertainment, politics and health at CNN.",
    url: "http://us.cnn.com",
    imageUrl: "https://play-lh.googleusercontent.com/375NW5yL8owK_hW9igW9sh-YJbda9ZcygpDXuVvK_R7l-yJp-fuhb4qvUw_FE4XW4ms",
    category: "general",
    language: "en",
    country: "us",
  ),
  bloomberg(
    id: "bloomberg",
    title: "Bloomberg",
    description:
    "Bloomberg delivers business and markets news, data, analysis, and video to the world, featuring stories from Businessweek and Bloomberg News.",
    url: "http://www.bloomberg.com",
    imageUrl: "https://eu-images.contentstack.com/v3/assets/blt2db30e0332fda6df/bltfeb0565eff9eee1f/673c610008af77790754ded9/bloomberg-news-logo.jpg",
    category: "business",
    language: "en",
    country: "us",
  );

  final String id;
  final String title;
  final String description;
  final String url;
  final String imageUrl;
  final String category;
  final String language;
  final String country;

  const NewsSourceEnum({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.imageUrl,
    required this.category,
    required this.language,
    required this.country,
  });

  static Map<String,NewsSourceEnum> sourceMap = {for(var e in values) e.id : e};
}

enum NewsFeedTabEnum {
  forYou("For you"),
  worldNews("World News"),
  headlines("Headlines"),
  local("Local");

  final String title;

  const NewsFeedTabEnum(this.title);
}
