import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/src/features/dashboard/controller/providers/image_picker_provider.dart';
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
                  Consumer(builder: (context, ref, _) {
                    return IconButton(
                      onPressed: () async {
                        ref
                            .read(imagePickerProvider.notifier)
                            .pickAndCropImage(source: ImageSource.camera);
                        if (context.mounted) context.back();
                      },
                      icon: const Icon(
                        Icons.camera,
                        size: 40,
                      ),
                      color: Theme.of(context).primaryColor,
                    );
                  }),
                  const Text("Camera"),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Consumer(builder: (context, ref, _) {
                    return IconButton(
                      onPressed: () async {
                        ref
                            .read(imagePickerProvider.notifier)
                            .pickAndCropImage(source: ImageSource.gallery);
                        if (context.mounted) context.back();
                      },
                      icon: const Icon(
                        Icons.image,
                        size: 40,
                      ),
                      color: Theme.of(context).primaryColor,
                    );
                  }),
                  const Text("Gallery"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<File?> _cropImage({required File imageFile})
}
