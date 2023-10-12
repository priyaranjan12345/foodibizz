import 'package:flutter/material.dart';
import 'package:foodibizz/src/features/dashboard/model/cart_food_item_model.dart';
import 'package:printing/printing.dart';

import '../data/service/printing_bill.dart';

class BillScreen extends StatelessWidget {
  const BillScreen({super.key, required this.cbl});

  final List<CartFoodItemModel> cbl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Billing"),
        centerTitle: true,
      ),
      body: Theme(
        data: ThemeData.dark(),
        child: PdfPreview(
          useActions: true,
          canDebug: false,
          loadingWidget: const Text("Loading Bill..."),
          build: (format) => PrintingBill().generateBill(format, cbl),
          onPrinted: (context) {
            // save bill
          },
        ),
      ),
    );
  }
}
