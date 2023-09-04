import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/data/apis/dashboard/dashboard_api_pod.dart';

import 'dashboard_repository.dart';
import 'i_dashboard_repository.dart';

final dashboardRepositoryProvider = Provider.autoDispose<IDashboardRepository>(
  (ref) => DashboardRepository(
    iDashboardApi: ref.watch(dashboardApiProvider),
  ),
);
