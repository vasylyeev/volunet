import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource imageSource) async {
  final ImagePicker imagePicker = ImagePicker();

  XFile? file = await imagePicker.pickImage(source: imageSource);

  if (file != null) {
    return await file.readAsBytes();
  }
  print('No Image selected');
}
