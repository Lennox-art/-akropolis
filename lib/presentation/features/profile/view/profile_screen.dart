import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/presentation/features/profile/model/profile_models.dart';
import 'package:akropolis/presentation/features/profile/view_model/profile_view_model.dart';
import 'package:akropolis/presentation/routes/routes.dart';
import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:akropolis/presentation/ui/components/toast/toast.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({required this.profileViewModel, super.key});

  final ProfileViewModel profileViewModel;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<ProfileSections> sections = ProfileSections.values;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: sections.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {},
            )
          ],
        ),
        body: ListenableBuilder(
          listenable: widget.profileViewModel,
          builder: (_, __) {
            return widget.profileViewModel.profileState.map(
              initial: (i) => IconButton(
                onPressed: widget.profileViewModel.initializeViewModel,
                icon: const Icon(Icons.refresh),
              ),
              loading: (_) => const InfiniteLoader(),
              loaded: (_) {
                AppUser currentUser = widget.profileViewModel.appUser!;
                return NestedScrollView(
                  headerSliverBuilder: (_, __) {
                    return [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Builder(builder: (context) {
                                String? profilePic = currentUser.profilePicture;
                                if (profilePic == null) {
                                  return CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.grey[800],
                                    child: const Icon(Icons.person, color: Colors.white, size: 30),
                                  );
                                }
                                return CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.grey[800],
                                  backgroundImage: NetworkImage(profilePic),
                                );
                              }),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${currentUser.displayName} (${currentUser.username})",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextButton(
                                    style: const ButtonStyle(
                                      padding: WidgetStatePropertyAll(EdgeInsets.zero),
                                      foregroundColor: WidgetStatePropertyAll(Colors.blue),
                                      textStyle: WidgetStatePropertyAll(
                                        TextStyle(color: Colors.blue, fontSize: 14),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                        AppRoutes.editProfile.path,
                                        arguments: currentUser,
                                      );
                                    },
                                    child: const Text('Edit Profile'),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                        child: Text(
                                          '${widget.profileViewModel.logicianCount?.toString() ?? '-'} LOGICIAN',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                        child: Text(
                                          '${widget.profileViewModel.empathCount?.toString() ?? '-'} EMPATH',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ];
                  },
                  body: Flex(
                    direction: Axis.vertical,
                    children: [
                      TabBar(
                        tabAlignment: TabAlignment.fill,
                        tabs: sections.map((s) => Tab(text: s.label)).toList(),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: sections
                              .map(
                                (s) => switch (s) {
                                  ProfileSections.myPosts => FinishProfileWidget(
                                      appUser: currentUser,
                                      tasks: [
                                        if ((widget.profileViewModel.postsCount ?? 1) < 1) ProfileTask.createPost,
                                        if (currentUser.profilePicture == null) ProfileTask.profilePicture,
                                        if (currentUser.bio == null) ProfileTask.bio,
                                        if ((currentUser.topics ?? {}).length < 10) ProfileTask.followTopics,
                                      ],
                                    ),
                                  ProfileSections.comments => const Center(child: Text("Comments")),
                                  ProfileSections.reactions => const Center(child: Text("Reactions")),
                                },
                              )
                              .toList(),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class FinishProfileWidget extends StatelessWidget {
  const FinishProfileWidget({required this.tasks, required this.appUser, super.key});

  final List<ProfileTask> tasks;
  final AppUser appUser;

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return const Center(
        child: Text("Profile set up"),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
      itemCount: tasks.length,
      itemBuilder: (context, i) {
        ProfileTask profileTask = tasks[i];
        return ProfileTaskWidget(
          profileTask: profileTask,
          onAction: () {
            switch (profileTask) {
              case ProfileTask.createPost:
                Navigator.of(context).pushNamed(AppRoutes.createPost.path);
                break;
              case ProfileTask.bio:
              case ProfileTask.profilePicture:
                Navigator.of(context).pushNamed(
                  AppRoutes.editProfile.path,
                  arguments: appUser,
                );
                break;
              case ProfileTask.followTopics:
                const ToastInfo(message: "Follow not yet implemented").show();
                break;
            }
          },
        );
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
    );
  }
}

class ProfileTaskWidget extends StatelessWidget {
  const ProfileTaskWidget({
    required this.profileTask,
    required this.onAction,
    super.key,
  });

  final ProfileTask profileTask;
  final Function() onAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Icon(profileTask.icon, color: Colors.white, size: 30),
          ),
          Text(
            profileTask.title,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(profileTask.subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12), textAlign: TextAlign.center),
          ),
          ElevatedButton(
            onPressed: () => onAction(),
            child: Text(profileTask.buttonText),
          )
        ],
      ),
    );
  }
}
