import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:foodibizz/global/extensions/focus_node_ext.dart';
import 'package:foodibizz/global/widgets/elevated_button_widget.dart';
import 'package:foodibizz/global/widgets/text_field_widget.dart';
import 'package:foodibizz/src/core/routes/app_routes.gr.dart';

@RoutePage(deferredLoading: true, name: "AddUpdateRoute")
class AddUpdateRecipeScreen extends StatefulWidget {
  const AddUpdateRecipeScreen({super.key});

  @override
  State<AddUpdateRecipeScreen> createState() => _AddUpdateRecipeScreenState();
}

class _AddUpdateRecipeScreenState extends State<AddUpdateRecipeScreen> {
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
        title: const Text("Recipe"),
      ),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            DottedBorder(
              borderType: BorderType.RRect,
              color: Theme.of(context).dividerColor,
              radius: const Radius.circular(12),
              padding: const EdgeInsets.all(6),
              dashPattern: const <double>[3, 3],
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: Container(
                  height: 200,
                  color: Theme.of(context).focusColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            context
                                .navigateTo(const FilePickerBottomSheetRoute());
                          },
                          icon: const Icon(Icons.image),
                          label: const Text(
                            "Select Image",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFieldWidget(
              controller: nameController,
              focusNode: nameFocusNode,
              label: "Name",
              hint: "Enter recipe name ",
              onFieldSubmitted: (value) {
                context.changeFocus(nameFocusNode, descFocusNode);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldWidget(
              controller: descController,
              focusNode: descFocusNode,
              label: "Description",
              hint: "Enter recipe description",
              onFieldSubmitted: (value) {
                context.changeFocus(descFocusNode, priceFocusNode);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldWidget(
              controller: priceController,
              focusNode: priceFocusNode,
              label: "Price",
              hint: "Enter recipe price",
              keyboardKey: TextInputType.number,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButtonWidget(buttonName: "submit", onPressed: () {})
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
