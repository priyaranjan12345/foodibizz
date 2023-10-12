import 'package:flutter/foundation.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../model/cart_food_item_model.dart';

class PrintingBill {
  Future<Uint8List> generateBill(
    PdfPageFormat format,
    List<CartFoodItemModel> cbl,
  ) async {
    final doc = pw.Document();

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            mainAxisSize: pw.MainAxisSize.min,
            children: [
              pw.Text(
                'FoodiBizz',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontSize: 30,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                'At- Housing Board Colony, F.C.I Twonship\nDist- Angul(O)- 759106\nMob- 902741097, 8976380189\nEmail- anymail@gmail.com',
                textAlign: pw.TextAlign.center,
                style: const pw.TextStyle(
                  fontSize: 22,
                ),
              ),
              pw.Text(
                '-' * 60,
                textAlign: pw.TextAlign.center,
                style: const pw.TextStyle(fontSize: 20),
              ),
              pw.Text(
                'INV-${DateTime.now().millisecondsSinceEpoch}',
                textAlign: pw.TextAlign.center,
                style: const pw.TextStyle(
                  fontSize: 20,
                ),
              ),
              pw.SizedBox(height: 30),
              pw.Text(
                '-' * 70,
                textAlign: pw.TextAlign.center,
                style: const pw.TextStyle(fontSize: 20),
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Name',
                    style: const pw.TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  pw.Text(
                    'Price',
                    style: const pw.TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  pw.Text(
                    'Qty',
                    style: const pw.TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  pw.Text(
                    'Total',
                    style: const pw.TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              pw.Text(
                '-' * 70,
                textAlign: pw.TextAlign.center,
                style: const pw.TextStyle(fontSize: 20),
              ),
              ...cbl.map(
                (e) => pw.Container(
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Expanded(
                        child: pw.Text(
                          e.name,
                          style: const pw.TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Text(
                          e.price.toString(),
                          textAlign: pw.TextAlign.center,
                          style: const pw.TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Text(
                          e.qty.toString(),
                          textAlign: pw.TextAlign.center,
                          style: const pw.TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Text(
                          '${e.price * e.qty}',
                          textAlign: pw.TextAlign.right,
                          style: const pw.TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              pw.Text(
                '-' * 70,
                textAlign: pw.TextAlign.center,
                style: const pw.TextStyle(fontSize: 20),
              ),
              pw.Text(
                'Grand Total: ${cbl.fold(0.0, (previousValue, element) => double.parse(previousValue.toString()) + (element.price * element.qty))}',
                textAlign: pw.TextAlign.right,
                style:
                    pw.TextStyle(fontSize: 26, fontWeight: pw.FontWeight.bold),
              ),
            ],
          );
        },
      ),
    );

    return doc.save();
  }
}
