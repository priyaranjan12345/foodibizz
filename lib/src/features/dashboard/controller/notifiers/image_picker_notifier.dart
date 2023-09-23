import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerNotifier extends StateNotifier<File?> {
  ImagePickerNotifier() : super(null);

  Future<void> pickAndCropImage({required ImageSource source}) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      final croppedImage = await ImageCropper().cropImage(
        sourcePath: pickedImage.path,
        aspectRatio: const CropAspectRatio(ratioX: 16, ratioY: 9),
      );
      if (croppedImage != null && state != File(croppedImage.path)) {
        state = File(croppedImage.path);
      }
    }
  }

  void clearImage() {
    state = null;
  }
}
