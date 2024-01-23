import 'package:flutter_test/flutter_test.dart';
import 'package:foodibizz/app.dart';

void main() {
  group('foodibizz app type', () {
    testWidgets("is a foodibizz app", (widgetTester) async {
      expect(const FoodibizzApp(), isA<FoodibizzApp>());
    });
  });
}
