import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/global/api_client/dio_client_pod.dart';

import 'generate_bill_api.dart';
import 'i_generate_bill_api.dart';

final generateBillApiPod = Provider.autoDispose<IGenerateBillApi>(
  (ref) => GenerateBillApi(
    dio: ref.watch(dioProvider),
  ),
  name: "generateBillApiPod",
);
