import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageService {
  final ImagePicker _picker = ImagePicker();

  Future<File?> uploadImage(ImageSource source) async {
    if (source == ImageSource.camera) {
      final cameraStatus = await Permission.camera.request();
      if (!cameraStatus.isGranted) {
        debugPrint('Camera permission not granted');
        return null;
      }
    } else if (source == ImageSource.gallery) {
      final photoStatus = await Permission.photos.request();
      if (!photoStatus.isGranted) {
        debugPrint('Photo permission not granted');
        return null;
      }
    }

    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        return File(pickedFile.path);
      }
    } catch (e) {
      debugPrint("Image picking error: $e");
    }

    return null;
  }

  Future<void> removeImage(File? image) async {
    if (image != null && await image.exists()) {
      await image.delete();
      debugPrint('Image removed: ${image.path}');
    }
  }
}
