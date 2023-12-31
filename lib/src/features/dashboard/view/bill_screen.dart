import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import 'package:foodibizz/src/features/dashboard/data/service/printing_bill.dart';
import 'package:foodibizz/src/features/dashboard/model/cart_food_item_model.dart';

@RoutePage(deferredLoading: true, name: "BillingRoute")
class BillingScreen extends StatelessWidget {
  const BillingScreen({super.key, required this.cbl});

  final List<CartItem> cbl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Receipt"),
        centerTitle: true,
      ),
      body: Theme(
        data: ThemeData.dark(),
        child: PdfPreview(
          useActions: true,
          canDebug: false,
          loadingWidget: const Text("Loading Bill..."),
          build: (format) => PrintingBill().generateBill(format, cbl),
          onPrinted: (context) {},
        ),
      ),
    );
  }
}
