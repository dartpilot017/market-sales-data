import 'dart:io';
import 'package:flutter/material.dart';

class UserPictureProvider extends ChangeNotifier {
  File? _userPicture;

  File? get userPicture => _userPicture;

  void updateUserPicture(File picture) {
    _userPicture = picture;
    notifyListeners();
  }
}
