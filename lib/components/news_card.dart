import 'package:akropolis/features/for_you_feed/models/for_you_models.dart';
import 'package:akropolis/features/world_news_feed/models/world_news_models.dart';
import 'package:akropolis/main.dart';
import 'package:akropolis/utils/functions.dart';
import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final String? newsImageUrl;
  final String title;
  final String? author;
  final String description;
  final DateTime publishedAt;
  final String? newsSourceImageUrl;

  const NewsCard({
    super.key,
    required this.newsImageUrl,
    required this.title,
    required this.author,
    required this.description,
    required this.publishedAt,
    required this.newsSourceImageUrl,
  });

  NewsCard.newsApi(NewsApiArticleModel news, {super.key})
      : newsImageUrl = news.urlToImage,
        title = news.title,
        author = news.author,
        description = news.description,
        publishedAt = news.publishedAt,
        newsSourceImageUrl = news.sourceEnum?.imageUrl {
    log.info(news);
  }

  NewsCard.mediaStack(MediaStackArticleModel news, {super.key})
      : newsImageUrl = news.image,
        title = news.title,
        author = news.author,
        description = news.description,
        publishedAt = news.publishedAt,
        newsSourceImageUrl = null {
    log.info(news);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(16.0),
            ),
            child: Visibility(
              replacement: const Icon(
                Icons.newspaper,
                size: 250,
              ),
              child: Image.network(
                newsImageUrl ?? '',
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.broken_image,
                  size: 50,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      author == null
                          ? Icons.question_mark_outlined
                          : Icons.person,
                      size: 18,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        author ?? "Unknown Author",
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      timeAgo(publishedAt),
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Visibility(
                      visible: newsSourceImageUrl != null,
                      replacement: const CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.yellow,
                      ),
                      child: CircleAvatar(
                        radius: 12,
                        backgroundImage: NetworkImage(
                          newsSourceImageUrl ?? '',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "+2 Replies",
                      style: TextStyle(fontSize: 14, color: Colors.blue),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.share, size: 18),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_vert, size: 18),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}