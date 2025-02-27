import 'dart:async';
import 'dart:collection';

import 'package:akropolis/presentation/features/on_boarding/models/on_boarding_models.dart';
import 'package:akropolis/presentation/features/on_boarding/view_model/on_boarding_view_model.dart';
import 'package:akropolis/presentation/routes/routes.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:akropolis/presentation/ui/themes.dart';
import 'package:flutter/material.dart';


class SelectTopicScreen extends StatefulWidget {
  const SelectTopicScreen({required this.onBoardingViewModel, super.key,});

  final OnBoardingViewModel onBoardingViewModel;

  @override
  State<SelectTopicScreen> createState() => _SelectTopicScreenState();
}

class _SelectTopicScreenState extends State<SelectTopicScreen> {


  late final StreamSubscription<ToastMessage> toastStreamSubscription;
  late final StreamSubscription<OnBoardingState> onBoardingStreamSubscription;

  @override
  void initState() {
    toastStreamSubscription = widget.onBoardingViewModel.toastStream.listen(_onToastMessage);
    onBoardingStreamSubscription = widget.onBoardingViewModel.onBoardingStateStream.listen(_onStateChange);
    super.initState();
  }

  void _onToastMessage(ToastMessage toast) {
    toast.show();
  }

  void _onStateChange(OnBoardingState state) {
    state.mapOrNull(
      notifications: (_) => Navigator.of(context).pushNamed(AppRoutes.welcomePreferences.path),
      cleared: (_) => Navigator.of(context).pushNamed(AppRoutes.home.path),
    );
  }

  @override
  void dispose() {
    toastStreamSubscription.cancel();
    onBoardingStreamSubscription.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final Set<String> selectedTopics = HashSet();

    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        appBar: AppBar(
          title: null,
        ),
        body: Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "What are you interested in?",
                style: theme.textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              "Add or edit the topics you follow. Choose six or more option you are interested.",
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InterestChips(
                  selectedTopics: selectedTopics,
                  minSelection: 6,
                  topics: widget.onBoardingViewModel.topics,
                  onSelectionChanged: (selectedTopics) {
                    print('Selected topics: $selectedTopics');
                  },
                ),
              ),
            ),

            ListenableBuilder(
              listenable: widget.onBoardingViewModel,
              builder: (_, __) {
                if(widget.onBoardingViewModel.onBoardingState is LoadingOnBoardingState) {
                  return const InfiniteLoader();
                }

                return ElevatedButton(
                  onPressed: () async {
                    widget.onBoardingViewModel.setTopics(topics: selectedTopics);
                  },
                  child: const Text("Next"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class InterestChips extends StatefulWidget {
  const InterestChips({
    super.key,
    this.minSelection = 6,
    this.topics = const [],
    required this.selectedTopics,
    this.onSelectionChanged,
  });

  final int minSelection;
  final List<String> topics;
  final Set<String> selectedTopics;
  final void Function(List<String>)? onSelectionChanged;

  @override
  State<InterestChips> createState() => _InterestChipsState();
}

class _InterestChipsState extends State<InterestChips> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: widget.topics.map((topic) {
        final isSelected = widget.selectedTopics.contains(topic);
        return FilterChip(
          selected: isSelected,
          label: Text(topic),
          onSelected: (selected) {
            setState(() {
              if (selected) {
                widget.selectedTopics.add(topic);
              } else {
                widget.selectedTopics.remove(topic);
              }
            });
            widget.onSelectionChanged?.call(widget.selectedTopics.toList());
          },
          backgroundColor: Colors.transparent,
          selectedColor: primaryColor,
          checkmarkColor: secondaryColor,
          side: BorderSide(
            color: isSelected ? Colors.transparent : Colors.white24,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        );
      }).toList(),
    );
  }
}
