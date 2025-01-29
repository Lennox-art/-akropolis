
import 'package:akropolis/features/world_news_feed/models/world_news_models.dart';
import 'package:akropolis/main.dart';
import 'package:akropolis/utils/functions.dart';
import 'package:flutter/material.dart';

class WorldNewsCard extends StatelessWidget {
  final WorldNewsModel news;

  const WorldNewsCard({super.key, required this.news});

  @override
  Widget build(BuildContext context) {

    ThemeData theme = Theme.of(context);


    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
            child: Image.network(
              news.urlToImage,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.broken_image, size: 50),
            ),
          ),

          // Content Section
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  news.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.person, size: 18, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          news.author ?? "Author",
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      timeAgo(news.publishedAt),
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),
                Text(
                  news.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14),
                ),

                const SizedBox(height: 8),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundImage: NetworkImage(
                        news.sourceEnum?.url ?? news.url,
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