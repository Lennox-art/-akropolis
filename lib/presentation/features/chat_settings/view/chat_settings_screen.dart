import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:akropolis/presentation/features/chat_settings/view_model/chat_settings_view_model.dart';
import 'package:flutter/material.dart';

class ChatSettingsScreen extends StatelessWidget {
  const ChatSettingsScreen({
    required this.chatSettingsViewModel,
    super.key,
  });

  final ChatSettingsViewModel chatSettingsViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat settings"),
        centerTitle: true,
      ),
      body: ListenableBuilder(
        listenable: chatSettingsViewModel,
        builder: (_, __) {
          AppUser user = chatSettingsViewModel.user;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTile(
                  leading: Builder(builder: (context) {
                    String? profilePic = chatSettingsViewModel.user.profilePicture;
                    if (profilePic == null) {
                      return CircleAvatar(
                        child: Icon(Icons.person),
                      );
                    }
                    return CircleAvatar(
                      backgroundImage: NetworkImage(profilePic),
                    );
                  }),
                  title: Text(user.displayName),
                  trailing: ElevatedButton(
                    style: const ButtonStyle(
                      fixedSize: WidgetStatePropertyAll(Size(100, 40)),
                      backgroundColor: WidgetStatePropertyAll(Colors.red)
                    ),
                    onPressed: () {
                      //TODO: Implement block

                    },
                    child: const Text("Block"),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "If you block someone, all the conversations they are part of will be removed",
                  ),
                ),
                Card(
                  child: SwitchListTile(
                    value: true,
                    title: Text("Notification"),
                    subtitle: Text("Turned On"),
                    onChanged: (v) {
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "Report this conversation",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
