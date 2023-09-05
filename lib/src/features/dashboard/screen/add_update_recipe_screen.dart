import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foodibizz/global/extensions/focus_node_ext.dart';
import 'package:foodibizz/global/widgets/elevated_button_widget.dart';
import 'package:foodibizz/global/widgets/text_field_widget.dart';

@RoutePage(deferredLoading: true, name: "AddUpdateRoute")
class AddUpdateRecipeScreen extends StatelessWidget {
  AddUpdateRecipeScreen({super.key});

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
          title: const Text("Recipes"),
        ),
        body: Form(
            child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
           
            TextFieldWidget(
              controller: nameController,
              focusNode: nameFocusNode,
              label: "Name",
              hint: "enter recipe name ",
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
              label: "Desc",
              hint: "enter recipe description",
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
              label: "price",
              hint: " enter recipe price",
              keyboardKey: TextInputType.number,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButtonWidget(buttonName: "submit", onPressed: () {})
          ],
        )));
  }
}
