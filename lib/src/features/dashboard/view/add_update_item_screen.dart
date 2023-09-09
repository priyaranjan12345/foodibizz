import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/providers/image_picker_provider.dart';
import '../../../core/constants/gaps.dart';
import '../../../core/routes/app_routes.gr.dart';
import '../../../../global/extensions/focus_node_ext.dart';
import '../../../../global/extensions/snackbar_ext.dart';
import '../../../../global/widgets/text_field_widget.dart';
import '../controller/providers/add_update_item_provider.dart';
import 'Widgets/submit_item_button.dart';

@RoutePage(deferredLoading: true, name: "AddUpdateItemRoute")
class AddUpdateItemScreen extends ConsumerStatefulWidget {
  const AddUpdateItemScreen({super.key});

  @override
  ConsumerState<AddUpdateItemScreen> createState() =>
      _AddUpdateItemScreenConsumerState();
}

class _AddUpdateItemScreenConsumerState
    extends ConsumerState<AddUpdateItemScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode descFocusNode = FocusNode();
  FocusNode priceFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add & Update Recipe"),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            DottedBorder(
              borderType: BorderType.RRect,
              color: Theme.of(context).primaryColor,
              radius: const Radius.circular(12),
              padding: const EdgeInsets.all(6),
              dashPattern: const <double>[3, 3],
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: Consumer(
                  builder: (context, ref, _) {
                    final imagePickerState = ref.watch(imagePickerProvider);
                    return imagePickerState == null
                        ? Container(
                            height: 200,
                            color: Theme.of(context).focusColor,
                            child: Center(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  context.navigateTo(
                                    const FilePickerBottomSheetRoute(),
                                  );
                                },
                                icon: const Icon(Icons.image),
                                label: const Text(
                                  "Select Image",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          )
                        : Stack(
                            children: [
                              SizedBox(
                                height: 200,
                                width: double.infinity,
                                child: Image.file(
                                  File(imagePickerState.path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Consumer(
                                builder: (context, ref, _) {
                                  return Align(
                                    alignment: Alignment.topRight,
                                    child: CircleAvatar(
                                      child: IconButton(
                                          onPressed: () {
                                            ref
                                                .read(imagePickerProvider
                                                    .notifier)
                                                .update((state) => null);
                                          },
                                          icon: const Icon(Icons.close)),
                                    ),
                                  );
                                },
                              )
                            ],
                          );
                  },
                ),
              ),
            ),
            gapH20,
            TextFieldWidget(
              controller: nameController,
              focusNode: nameFocusNode,
              label: "Name",
              hint: "Enter recipe name ",
              onFieldSubmitted: (value) {
                context.changeFocus(nameFocusNode, descFocusNode);
              },
              validator: (p0) {
                if (p0 != null && p0.isNotEmpty) {
                  return null;
                }

                return "Name required";
              },
            ),
            gapH20,
            TextFieldWidget(
              controller: descController,
              focusNode: descFocusNode,
              label: "Description",
              hint: "Enter recipe description",
              onFieldSubmitted: (value) {
                context.changeFocus(descFocusNode, priceFocusNode);
              },
              validator: (p0) {
                if (p0 != null && p0.isNotEmpty) {
                  return null;
                }

                return "Description required";
              },
            ),
            gapH20,
            TextFieldWidget(
              controller: priceController,
              focusNode: priceFocusNode,
              label: "Price",
              hint: "Enter recipe price",
              keyboardKey: TextInputType.number,
              validator: (p0) {
                if (p0 != null && p0.isNotEmpty) {
                  return null;
                }

                return "Price required";
              },
              inputFormatters: <TextInputFormatter>[
                // FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
              ],
            ),
            gapH20,
            Center(
              child: SubmitItemButton(
                onSubmit: () {
                  if (!formKey.currentState!.validate()) return;

                  final imageXFile = ref.read(imagePickerProvider);
                  if (imageXFile != null) {
                    ref.read(addUpdateItemProvider.notifier).addRecipe(
                          img: File(imageXFile.path),
                          name: nameController.text,
                          desc: descController.text,
                          price: double.parse(priceController.text),
                        );
                  } else {
                    final snakBar = SnackBar(
                      content: const Text("Please select item image"),
                      action: SnackBarAction(
                        label: "Cancel",
                        onPressed: () => context.clearSnackBar(),
                      ),
                    );
                    context.showSnackBar(snakBar);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    priceController.dispose();

    nameFocusNode.dispose();
    descFocusNode.dispose();
    priceFocusNode.dispose();
    super.dispose();
  }
}
