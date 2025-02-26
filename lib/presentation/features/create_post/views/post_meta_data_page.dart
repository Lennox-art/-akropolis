import 'package:akropolis/presentation/features/create_post/view_model/create_post_view_model.dart';
import 'package:akropolis/presentation/routes/routes.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:flutter/material.dart';

class PostMetaDataPage extends StatefulWidget {
  const PostMetaDataPage({
    required this.createPostViewModel,
    super.key,
  });

  final CreatePostViewModel createPostViewModel;

  @override
  State<PostMetaDataPage> createState() => _PostMetaDataPageState();
}

class _PostMetaDataPageState extends State<PostMetaDataPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: null,
      ),
      body: ListenableBuilder(
        listenable: widget.createPostViewModel,
        builder: (_, state) {
          return Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Card(
                  child: widget.createPostViewModel.createPostState.map(
                    loading: (l) => const InfiniteLoader(),
                    loaded: (l) {

                      return ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16.0),
                        ),
                        child: Image.memory(
                          widget.createPostViewModel.thumbnailData!,
                          fit: BoxFit.fill,
                        ),
                      );
                    },
                  ),
                ),
              ),
              ListTile(
                title: const Text("Description"),
                subtitle: TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: "Title",
                  ),
                ),
              ),
              ListTile(
                title: const Text("Description"),
                subtitle: TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    hintText: "Description",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    String title = titleController.text;
                    String description = descriptionController.text;

                    widget.createPostViewModel.doPost(
                      title: title,
                      description: description,
                    );

                    Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.home.path,
                      (_) => false,
                    );
                  },
                  child: const Text("Post"),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
