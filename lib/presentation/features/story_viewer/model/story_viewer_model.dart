import 'package:akropolis/data/models/remote_models/remote_models.dart';

class StoryViewerDto {
  final List<UserStory> initialStories;
  final UserStory initialStory;
  final AppUser currentUser;

  StoryViewerDto({
    required this.initialStories,
    required this.initialStory,
    required this.currentUser,
  });
}
