import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/src/features/dashboard/data/apis/generate_bill_api/generate_bill_api_pod.dart';
import 'package:foodibizz/src/features/dashboard/data/repository/generate_bill_repository/generate_bill_repository.dart';
import 'package:foodibizz/src/features/dashboard/data/repository/generate_bill_repository/i_generate_bill_repository.dart';

final generateBillRepoPod = Provider.autoDispose<IGenerateBillRepository>(
  (ref) => GenerateBillRepository(
    iGenerateBillApi: ref.watch(generateBillApiPod),
  ),
  name: "generateBillRepoPod",
);
