import 'package:akropolis/features/authentication/view_model/authentication_cubit/authentication_cubit.dart';
import 'package:akropolis/features/news_feed/view/for_you.dart';
import 'package:akropolis/utils/constants.dart';
import 'package:akropolis/features/news_feed/view/local_news.dart';
import 'package:akropolis/features/news_feed/view/headlines.dart';
import 'package:akropolis/features/news_feed/view/world_news.dart';
import 'package:akropolis/routes/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'news_feed/models/models.dart';

enum HomeTabs {
  forYou("For you"),
  worldNews("World News"),
  headlines("Headlines"),
  local("Local");

  final String title;

  const HomeTabs(this.title);
}

enum BottomNavigationTabs {
  home("Home", Icons.home),
  search("Search", Icons.search),
  post("New Post", Icons.add),
  chat("Chat", Icons.chat),
  profile("Profile", Icons.person_outline);

  final String title;
  final IconData icon;

  const BottomNavigationTabs(this.title, this.icon);
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final List<HomeTabs> tabs = HomeTabs.values;
  final List<BottomNavigationTabs> bottomTabs = BottomNavigationTabs.values;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<BottomNavigationTabs> bottomValue = ValueNotifier(
      BottomNavigationTabs.home,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<AuthenticationCubit>(context).logout();
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.login.path,
                (_) => false,
              );
            },
            icon: const Icon(
              Icons.logout_outlined,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: DefaultTabController(
        length: tabs.length,
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  const SizedBox(
                    width: 150,
                    child: Card(
                      child: Text("Emblems"),
                    ),
                  ),
                  const SizedBox(
                    width: 150,
                    child: Card(
                      child: Text("See what's trending today"),
                    ),
                  ),
                  const SizedBox(
                    width: 150,
                    child: Card(
                      child: Text("Today's view count"),
                    ),
                  ),
                ],
              ),
            ),
            TabBar(
              isScrollable: true,
              tabs: tabs
                  .map(
                    (t) => Tab(
                      text: t.title,
                    ),
                  )
                  .toList(),
            ),
            Expanded(
              child: TabBarView(
                children: tabs
                    .map(
                      (t) => switch (t) {
                        HomeTabs.forYou => const ForYouContent(),
                        HomeTabs.worldNews => const WorldNewsContent(),
                        HomeTabs.headlines => const HeadlinesContent(),
                        HomeTabs.local => const LocalNewsContent(),
                      },
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: bottomValue,
        builder: (_, value, __) => BottomNavigationBar(
          currentIndex: value.index,
          onTap: (i) {
            switch (bottomTabs[i]) {
              case BottomNavigationTabs.post:
                Navigator.of(context).pushNamed(
                  AppRoutes.createPost.path,
                );
                break;
              default:
                bottomValue.value = bottomTabs[i];
                break;
            }
          },
          items: bottomTabs.map(
                (e) => BottomNavigationBarItem(
                  label: e.title,
                  icon: Icon(e.icon),
                  tooltip: e.title,
                ),
              ).toList(),
        ),
      ),
    );
  }
}
