import 'package:akropolis/data/models/remote_models/remote_models.dart';
import 'package:flutter/material.dart';

class ChatSettingsViewModel extends ChangeNotifier {
  final AppUser _user;

  ChatSettingsViewModel({required AppUser user}) : _user = user;


  AppUser get user => _user;

}