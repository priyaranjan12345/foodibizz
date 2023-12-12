import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/global/api_client/dio_client_pod.dart';
import 'package:foodibizz/src/features/dashboard/data/apis/generate_bill_api/generate_bill_api.dart';
import 'package:foodibizz/src/features/dashboard/data/apis/generate_bill_api/i_generate_bill_api.dart';


final generateBillApiPod = Provider.autoDispose<IGenerateBillApi>(
  (ref) => GenerateBillApi(
    dio: ref.watch(dioProvider),
  ),
  name: "generateBillApiPod",
);
