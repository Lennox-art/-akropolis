import 'package:akropolis/routes/routes.dart';
import 'package:akropolis/theme/themes.dart';
import 'package:flutter/material.dart';

class SelectTopicScreen extends StatelessWidget {
  const SelectTopicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: null,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "What are you interested in?",
                style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              "Add or edit the topics you follow. Choose six or more option you are interested.",
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InterestChips(
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
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.welcomePreferences.path,
                  (_) => false,
                );
              },
              child: const Text("Next"),
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
    this.onSelectionChanged,
  });

  final int minSelection;
  final List<String> topics;
  final void Function(List<String>)? onSelectionChanged;

  @override
  State<InterestChips> createState() => _InterestChipsState();
}

class _InterestChipsState extends State<InterestChips> {
  final Set<String> _selectedTopics = {};

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: widget.topics.map((topic) {
        final isSelected = _selectedTopics.contains(topic);
        return FilterChip(
          selected: isSelected,
          label: Text(topic),
          onSelected: (selected) {
            setState(() {
              if (selected) {
                _selectedTopics.add(topic);
              } else {
                _selectedTopics.remove(topic);
              }
            });
            widget.onSelectionChanged?.call(_selectedTopics.toList());
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
