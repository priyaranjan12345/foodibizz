import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifiers/generate_bill_notifier.dart';
import '../states/generate_bill_state.dart';

final generateBillProvider =
    AutoDisposeAsyncNotifierProvider<GenerateBillNotifier, GenerateBillState>(
  () => GenerateBillNotifier(),
  name: "createOrderProvider",
);
