import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/src/features/dashboard/model/all_food_items_response.dart';

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
  const AddUpdateItemScreen({
    super.key,
    this.item,
  });

  final FoodItem? item;

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
  void initState() {
    super.initState();

    if (widget.item != null) {
      nameController.text = widget.item?.name ?? '';
      descController.text = widget.item?.desc ?? '';
      priceController.text = (widget.item?.price ?? 0).toString();
    }
  }

  void addItem(WidgetRef ref) {
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
  }

  void updateItem() {}

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
                        ? widget.item == null
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
                            : CachedNetworkImage(
                                imageUrl:
                                    "http://3.27.90.34:8000/${widget.item?.image}",
                                errorWidget: (context, url, error) =>
                                    Image.asset('nope-not-here.webp'),
                                placeholder: (context, url) =>
                                    Image.asset('assets/no-image.jpg'),
                                fit: BoxFit.cover,
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
                              Align(
                                alignment: Alignment.topRight,
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Theme.of(context)
                                      .cardColor
                                      .withOpacity(0.6),
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      ref
                                          .read(imagePickerProvider.notifier)
                                          .update((state) => null);
                                    },
                                    icon: const Icon(Icons.close),
                                  ),
                                ),
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
              maxLines: 4,
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
                  if (widget.item == null) {
                    addItem(ref);
                  } else {
                    updateItem();
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