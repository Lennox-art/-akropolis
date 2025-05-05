import 'package:akropolis/presentation/features/settings/model/settings_model.dart';
import 'package:akropolis/presentation/ui/themes.dart';
import 'package:flutter/material.dart';

class PostAndReplyNotificationScreen extends StatefulWidget {
  const PostAndReplyNotificationScreen({super.key});

  @override
  State<PostAndReplyNotificationScreen> createState() => _PostAndReplyNotificationScreenState();
}

class _PostAndReplyNotificationScreenState extends State<PostAndReplyNotificationScreen> {
  final ValueNotifier<SettingOptions> reactionNotifier = ValueNotifier(SettingOptions.forEveryone);
  final ValueNotifier<SettingOptions> repliesNotifier = ValueNotifier(SettingOptions.forEveryone);
  final ValueNotifier<SettingOptions> postActivityNotifier = ValueNotifier(SettingOptions.on);
  final ValueNotifier<SettingOptions> postSharingNotifier = ValueNotifier(SettingOptions.on);
  final ValueNotifier<SettingOptions> chosenForYouNotifier = ValueNotifier(SettingOptions.on);
  final ValueNotifier<SettingOptions> reminderNotifier = ValueNotifier(SettingOptions.on);
  final ValueNotifier<SettingOptions> trendingNowNotifier = ValueNotifier(SettingOptions.on);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post and replies'),
      ),
      body: ListView(
        children: [

          ListTile(
            title: const Text(
              'Reactions',
              style: TextStyle(color: primaryColor),
            ),
            subtitle: ValueListenableBuilder(
              valueListenable: reactionNotifier,
              builder: (_, value, __) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: SettingOptions.forEveryoneOff.map((e) {
                    return RadioListTile<SettingOptions>(
                      title: Text(e.title),
                      value: e,
                      groupValue: value,
                      onChanged: (value) {
                        if (value == null) return;
                        reactionNotifier.value = value;
                      },
                    );
                  }).toList(),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Ex: johnappleseed reacted to your post',
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
            ),
          ),

          ListTile(
            title: const Text(
              'Replies',
              style: TextStyle(color: primaryColor),
            ),
            subtitle: ValueListenableBuilder(
              valueListenable: repliesNotifier,
              builder: (_, value, __) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: SettingOptions.forEveryoneOff.map((e) {
                    return RadioListTile<SettingOptions>(
                      title: Text(e.title),
                      value: e,
                      groupValue: value,
                      onChanged: (value) {
                        if (value == null) return;
                        repliesNotifier.value = value;
                      },
                    );
                  }).toList(),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Ex: johnappleseed replied to your post',
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
            ),
          ),

          ListTile(
            title: const Text(
              'Post Activity Insights',
              style: TextStyle(color: primaryColor),
            ),
            subtitle: ValueListenableBuilder(
              valueListenable: postActivityNotifier,
              builder: (_, value, __) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: SettingOptions.offOn.map((e) {
                    return RadioListTile<SettingOptions>(
                      title: Text(e.title),
                      value: e,
                      groupValue: value,
                      onChanged: (value) {
                        if (value == null) return;
                        postActivityNotifier.value = value;
                      },
                    );
                  }).toList(),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Your post got 50k views, downloaded 10 times',
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
            ),
          ),

          ListTile(
            title: const Text(
              'Post Sharing',
              style: TextStyle(color: primaryColor),
            ),
            subtitle: ValueListenableBuilder(
              valueListenable: postSharingNotifier,
              builder: (_, value, __) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: SettingOptions.offOn.map((e) {
                    return RadioListTile<SettingOptions>(
                      title: Text(e.title),
                      value: e,
                      groupValue: value,
                      onChanged: (value) {
                        if (value == null) return;
                        postSharingNotifier.value = value;
                      },
                    );
                  }).toList(),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Ex: johnappleseed shared your post',
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
            ),
          ),

          ListTile(
            title: const Text(
              'Choose for you',
              style: TextStyle(color: primaryColor),
            ),
            subtitle: ValueListenableBuilder(
              valueListenable: chosenForYouNotifier,
              builder: (_, value, __) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: SettingOptions.offOn.map((e) {
                    return RadioListTile<SettingOptions>(
                      title: Text(e.title),
                      value: e,
                      groupValue: value,
                      onChanged: (value) {
                        if (value == null) return;
                        chosenForYouNotifier.value = value;
                      },
                    );
                  }).toList(),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "Picked for you: johnappleseed's post",
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
            ),
          ),

          ListTile(
            title: const Text(
              'Reminder',
              style: TextStyle(color: primaryColor),
            ),
            subtitle: ValueListenableBuilder(
              valueListenable: reminderNotifier,
              builder: (_, value, __) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: SettingOptions.offOn.map((e) {
                    return RadioListTile<SettingOptions>(
                      title: Text(e.title),
                      value: e,
                      groupValue: value,
                      onChanged: (value) {
                        if (value == null) return;
                        reminderNotifier.value = value;
                      },
                    );
                  }).toList(),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "You have 5 new replies and 20 reactions",
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
            ),
          ),

          ListTile(
            title: const Text(
              'Trending now',
              style: TextStyle(color: primaryColor),
            ),
            subtitle: ValueListenableBuilder(
              valueListenable: trendingNowNotifier,
              builder: (_, value, __) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: SettingOptions.offOn.map((e) {
                    return RadioListTile<SettingOptions>(
                      title: Text(e.title),
                      value: e,
                      groupValue: value,
                      onChanged: (value) {
                        if (value == null) return;
                        trendingNowNotifier.value = value;
                      },
                    );
                  }).toList(),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "See what people are saying about 'soccer', 'award shows', and more",
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
