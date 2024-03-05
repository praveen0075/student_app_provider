import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProvider extends ChangeNotifier{
  String? profilePicturePath;
  XFile? image;

  void setImage(XFile? img) {
    image = img;
    profilePicturePath = img?.path;
    notifyListeners();
  }

  void clearImage() {
    image = null;
    profilePicturePath = null;
    notifyListeners();
  }
}