import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/src/features/dashboard/controller/notifiers/image_picker_notifier.dart';

final imagePickerProvider =
    StateNotifierProvider.autoDispose<ImagePickerNotifier, File?>(
  (ref) => ImagePickerNotifier(),
  name: "imagePickerProvider",
);
