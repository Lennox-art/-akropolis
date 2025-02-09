import 'package:akropolis/features/create_post/models/models.dart';
import 'package:akropolis/features/for_you_feed/models/for_you_models.dart';
import 'package:akropolis/features/world_news_feed/models/world_news_models.dart';
import 'package:akropolis/main.dart';
import 'package:akropolis/utils/functions.dart';
import 'package:common_fn/common_fn.dart';
import 'package:flutter/material.dart';


class NewsCard extends StatelessWidget {
  final NewsPost post;

  const NewsCard({
    super.key,
    required this.post,
  });


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
                post.thumbnailUrl,
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
                  post.title,
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
                    const Icon(
                      Icons.person,
                      size: 18,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        post.author.name,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      timeAgo(post.publishedAt),
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  post.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Visibility(
                      visible: post.author.imageUrl != null,
                      replacement: const CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.yellow,
                      ),
                      child: CircleAvatar(
                        radius: 12,
                        backgroundImage: NetworkImage(
                          post.author.imageUrl ?? '',
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
