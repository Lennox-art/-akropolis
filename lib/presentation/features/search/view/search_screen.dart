import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/presentation/features/search/model/search_model.dart';
import 'package:akropolis/presentation/features/search/view_model/search_view_model.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({
    required this.searchViewModel,
    super.key,
  });

  final SearchViewModel searchViewModel;
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Explore"),
      ),
      body: ListenableBuilder(
        listenable: searchViewModel,
        builder: (_, __) {
          List<NewsPost> newsPosts = searchViewModel.searchedPosts;
          SearchState state = searchViewModel.state;
          return Flex(
            direction: Axis.vertical,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: SearchBar(
                  controller: searchController,
                  leading: const Icon(Icons.search),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  hintStyle: const WidgetStatePropertyAll(
                    TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  hintText: "Search feeds",
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: searchViewModel.categories.map((c) {
                    return GestureDetector(
                      onTap: () => searchViewModel.selectCategory(c),
                      child: Card(
                        color: c == searchViewModel.currentCategory ? theme.colorScheme.primary : theme.cardColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(c.label),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Expanded(
                child: switch (state) {
                  LoadingSearchState() => const InfiniteLoader(),
                  LoadedSearchState() => Visibility(
                      visible: newsPosts.isNotEmpty,
                      replacement: Center(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.search,
                                  size: 40,
                                ),
                              ),
                              Text(
                                state.showNotFound ? "No search results Found!" : "Search for a post",
                              ),
                            ],
                          ),
                        ),
                      ),
                      child: ListView.builder(
                        itemCount: newsPosts.length,
                        itemBuilder: (_, i) {
                          NewsPost post = newsPosts[i];
                          return ListTile(
                            title: Text(post.title),
                          );
                        },
                      ),
                    ),
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
