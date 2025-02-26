import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:exception_base/exception_base.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_models.freezed.dart';

@freezed
class HomeState with _$HomeState {

  const factory HomeState.initial() = InitialHomeState;

  const factory HomeState.error({required AppFailure failure}) = ErrorHomeState;

  const factory HomeState.loading() = LoadingHomeState;

  const factory HomeState.ready({required AppUser appUser}) = ReadyHomeState;

}

class Story {
  final String title;
  final String url;

  const Story({
    required this.title,
    required this.url,
  });
}


enum BottomNavigationTabs {
  newsFeed("Home", Icons.home),
  search("Search", Icons.search),
  post("New Post", Icons.add_box),
  chat("Chat", Icons.chat),
  profile("Profile", Icons.person_outline);

  final String title;
  final IconData icon;

  const BottomNavigationTabs(this.title, this.icon);
}
