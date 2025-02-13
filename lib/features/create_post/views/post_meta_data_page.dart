import 'package:akropolis/features/create_post/view_model/create_post_cubit.dart';
import 'package:akropolis/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:akropolis/components/loader.dart';


class PostMetaDataPage extends StatelessWidget {
  const PostMetaDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: null,
      ),
      body: BlocBuilder<CreatePostCubit, CreatePostState>(
        builder: (_, state) {
          return Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Card(
                  child: state.map(
                    loading: (l) => const InfiniteLoader(),
                    loaded: (l) {

                      if(l.form == null) {
                        return const Text("No video");
                      }

                      if(l.form?.thumbnailData == null) {
                        return const Text("No thumbnail");
                      }

                      return Visibility(
                        visible: l.form != null,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(16.0),
                          ),
                          child: Image.memory(
                            l.form!.thumbnailData!,
                            fit: BoxFit.fill,
                          ),
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

                    BlocProvider.of<CreatePostCubit>(context).doPost(
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
