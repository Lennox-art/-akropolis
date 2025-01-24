import 'dart:collection';

import 'package:akropolis/models/extensions.dart';
import 'package:akropolis/models/models.dart';
import 'package:akropolis/routes/routes.dart';
import 'package:akropolis/state/user_cubit/user_cubit.dart';
import 'package:akropolis/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectTopicScreen extends StatelessWidget {
  const SelectTopicScreen({super.key});

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
                  topics: const [
                    'Akropolis',
                    'Programming',
                    'Life',
                    'Technology',
                    'Relationship',
                    'News',
                    'Cryptocurrency',
                    'Business',
                    'Politics',
                    'Startup',
                    'Design',
                    'Software Development',
                    'Building',
                    'Artificial Intelligence',
                    'Art',
                    'Blockchain',
                    'Culture',
                    'Farming',
                    'Music',
                    'Car',
                    'Kenya',
                    'DJ',
                    'Mobile Phone',
                    'Football',
                    'Graph',
                    'Productivity',
                    'Health',
                    'Psychology',
                    'Writing',
                    'Love',
                    'Science',
                  ],
                  onSelectionChanged: (selectedTopics) {
                    print('Selected topics: $selectedTopics');
                  },
                ),
              ),
            ),
            BlocConsumer<UserCubit, UserState>(
              listener:  (context, state) {
                state.mapOrNull(
                  loaded: (l) {
                    l.toast?.show();
                  },
                );
              },
              builder: (context, state) {
                return state.map(
                  loaded: (l) {
                    return ElevatedButton(
                      onPressed: () async {

                        AppUser? currentUser = await BlocProvider.of<UserCubit>(context).getCurrentUser();
                        if(currentUser == null) return;
                        if(!context.mounted) return;

                        currentUser.topics = selectedTopics;

                        await BlocProvider.of<UserCubit>(context).saveAppUser(currentUser);
                        if(!context.mounted) return;

                        Navigator.of(context).pushNamedAndRemoveUntil(
                          AppRoutes.welcomePreferences.path,
                          (_) => false,
                        );
                      },
                      child: const Text("Next"),
                    );
                  },
                  loading: (_) => const CircularProgressIndicator.adaptive(),
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
