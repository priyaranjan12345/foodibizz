import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

@RoutePage(deferredLoading: true, name: "FilePickerBottomSheetRoute")
class FilePickerBottomSheet extends StatelessWidget {
  const FilePickerBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      backgroundColor: Colors.transparent,
      onClosing: () {},
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      final ImagePicker picker = ImagePicker();
                      picker.pickImage(source: ImageSource.camera);
                    },
                    icon: const Icon(
                      Icons.camera,
                      size: 40,
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                  const Text("Camera"),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      final ImagePicker picker = ImagePicker();
                      picker.pickImage(source: ImageSource.gallery);
                    },
                    icon: const Icon(
                      Icons.image,
                      size: 40,
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                  const Text("Gallery"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
