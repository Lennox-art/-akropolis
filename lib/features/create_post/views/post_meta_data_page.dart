import 'package:akropolis/features/create_post/view_model/create_post_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostMetaDataPage extends StatelessWidget {
  const PostMetaDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Finalize post"),
      ),
      body: BlocBuilder<CreatePostCubit, CreatePostState>(
        builder: (_, state) {
          return Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(

              ),
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(label: Text("Title")),
              ),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(label: Text("Description")),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Post"),
              ),
            ],
          );
        },
      ),
    );
  }
}
