import 'package:akropolis/presentation/features/search/view_model/search_view_model.dart';
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
          return ListView(
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
            ],
          );
        },
      ),
    );
  }
}
