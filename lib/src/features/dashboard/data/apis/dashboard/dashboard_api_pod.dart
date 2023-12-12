import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/global/api_client/dio_client_pod.dart';


import 'dashboard_api.dart';
import 'i_dashboard_api.dart';

final dashboardApiProvider = Provider.autoDispose<IDashboardApi>(
  (ref) => DashboardApi(
    dio: ref.watch(dioProvider),
  ),
);
