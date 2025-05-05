import 'package:akropolis/domain/use_cases/fetch_post_comments_use_case.dart';
import 'package:akropolis/presentation/features/create_post/view_model/create_post_view_model.dart';
import 'package:akropolis/presentation/features/settings/model/settings_state.dart';
import 'package:akropolis/presentation/features/settings/view_model/settings_view_model.dart';
import 'package:akropolis/presentation/routes/routes.dart';
import 'package:akropolis/presentation/ui/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    required this.settingsViewModel,
    super.key,
  });

  final SettingsViewModel settingsViewModel;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    widget.settingsViewModel.addListener(() => _onStateChange(widget.settingsViewModel.settingsState));
    super.initState();
  }

  @override
  void dispose() {
    widget.settingsViewModel.dispose();
    super.dispose();
  }

  void _onStateChange(SettingsState state) {
    state.mapOrNull(loggedOut: (_) {
      //User has logged out
      GetIt.I<FetchPostCommentsUseCase>().reset();
      GetIt.I<CreatePostViewModel>().reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              top: 10.0,
            ),
            child: Text(
              'Global settings',
              style: TextStyle(color: primaryColor),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(
                AppRoutes.notificationSettings.path,
              );
            },
            leading: const Icon(Icons.notifications_outlined),
            title: const Text("Notifications"),
            trailing: const Icon(Icons.chevron_right),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(
                AppRoutes.bookmarks.path,
              );
            },
            leading: const Icon(Icons.bookmark_border),
            title: const Text("Bookmarks"),
            trailing: const Icon(Icons.chevron_right),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(
                AppRoutes.watchLater.path,
              );
            },
            leading: const Icon(Icons.ondemand_video_sharp),
            title: const Text("Watch later"),
            trailing: const Icon(Icons.chevron_right),
          ),

          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(
                AppRoutes.blocked.path,
              );
            },
            leading: const Icon(
              Icons.person,
              color: Colors.red,
            ),
            title: const Text("Blocked users"),
            trailing: const Icon(Icons.chevron_right),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Account',
              style: TextStyle(color: primaryColor),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.question_mark_outlined),
            title: Text("Terms & conditions"),
            trailing: Icon(Icons.chevron_right),
          ),
          const ListTile(
            leading: Icon(Icons.person_2),
            title: Text("Help"),
            trailing: Icon(Icons.open_in_new_outlined),
          ),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text("About"),
            trailing: Icon(Icons.chevron_right),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Version Info',
              style: TextStyle(color: primaryColor),
            ),
          ),
          const ListTile(
            title: Text("Clear cache"),
            trailing: Text('5.5MB'),
          ),
          const ListTile(
            title: Text("Version"),
            trailing: Text('7.7.04.1009'),
          ),
          TextButton(
            style: const ButtonStyle(foregroundColor: WidgetStatePropertyAll(Colors.red)),
            onPressed: () {
              widget.settingsViewModel.logout();
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.login.path,
                (_) => false,
              );
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }
}
