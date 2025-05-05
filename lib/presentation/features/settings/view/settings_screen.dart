import 'package:akropolis/domain/use_cases/fetch_post_comments_use_case.dart';
import 'package:akropolis/presentation/features/create_post/view_model/create_post_view_model.dart';
import 'package:akropolis/presentation/features/settings/model/settings_state.dart';
import 'package:akropolis/presentation/features/settings/view_model/settings_view_model.dart';
import 'package:akropolis/presentation/routes/routes.dart';
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
      ),
      body: Center(
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.red)
          ),
          onPressed: () {
            widget.settingsViewModel.logout();
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.login.path,
                  (_) => false,
            );
          },
          child: Text("Logout"),
        ),
      ),
    );
  }
}
