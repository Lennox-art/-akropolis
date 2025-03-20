
import 'package:akropolis/presentation/features/on_boarding/view/select_topic.dart';
import 'package:akropolis/presentation/features/topics/view_model/topics_view_model.dart';
import 'package:flutter/material.dart';

class EditTopicsScreen extends StatelessWidget {
  const EditTopicsScreen({required this.topicsViewModel, super.key});

  final TopicsViewModel topicsViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Topics"),
      ),
      body: ListenableBuilder(
        listenable: topicsViewModel,
        builder: (_, __) {

          return Flex(
            direction: Axis.vertical,
            children: [
              Expanded(
                child: InterestChips(
                  selectedTopics: topicsViewModel.selectedTopics.toSet(),
                  minSelection: 10,
                  topics: topicsViewModel.topics,
                  onSelectionChanged: (updatedSelectedTopics) {
                    topicsViewModel.updateList(updatedSelectedTopics);
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  topicsViewModel.updateTopics();
                },
                child: Text("Confirm"),
              ),
            ],
          );
        },
      ),
    );
  }
}
