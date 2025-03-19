import 'package:akropolis/presentation/features/profile/model/profile_models.dart';
import 'package:akropolis/presentation/features/profile/view_model/profile_view_model.dart';
import 'package:akropolis/presentation/routes/routes.dart';
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
        body: NestedScrollView(
          headerSliverBuilder: (_, __) {
            return [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey[800],
                        child: Icon(Icons.person, color: Colors.white, size: 30),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Lennox Kimberly', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                          TextButton(
                            child: Text('Edit Profile'),
                            style: ButtonStyle(
                              padding: WidgetStatePropertyAll(EdgeInsets.zero),
                              foregroundColor: WidgetStatePropertyAll(Colors.blue),
                              textStyle: WidgetStatePropertyAll(
                                TextStyle(color: Colors.blue, fontSize: 14),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushNamed(AppRoutes.editProfile.path);
                            },
                          ),
                          Row(
                            children: [
                              Text('0 LOGICIAN', style: TextStyle(color: Colors.grey, fontSize: 12)),
                              SizedBox(width: 10),
                              Text('0 EMPATH', style: TextStyle(color: Colors.grey, fontSize: 12)),
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
              const TabBar(
                tabAlignment: TabAlignment.fill,
                tabs: [
                  Tab(text: 'My Post'),
                  Tab(text: 'Comments'),
                  Tab(text: 'Reactions'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: sections
                      .map((s) => switch (s) {
                            ProfileSections.myPosts => const FinishProfileWidget(),
                            ProfileSections.comments => Text("Comments"),
                            ProfileSections.reactions => Text("Reactions"),
                          })
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FinishProfileWidget extends StatelessWidget {
  const FinishProfileWidget({super.key});

  final List<ProfileTask> tasks = ProfileTask.values;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
      itemCount: tasks.length,
      itemBuilder: (context, i) {
        ProfileTask profileTask = tasks[i];
        return ProfileTaskWidget(profileTask: profileTask);
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
    super.key,
  });

  final ProfileTask profileTask;

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
            onPressed: () {},
            child: Text(profileTask.buttonText),
          )
        ],
      ),
    );
  }
}
