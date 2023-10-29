// ignore_for_file: unused_element, non_constant_identifier_names

import 'dart:io';

import 'package:image_cropper/image_cropper.dart';

Future<File?> CropImage(String path) async {
  CroppedFile? croppedImage = await ImageCropper().cropImage(sourcePath: path);
  if (croppedImage == null) return null;
  return File(croppedImage.path);
}

_uploadFile() async {}
