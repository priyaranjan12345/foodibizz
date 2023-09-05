import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/src/features/dashboard/data/services/dashboard_api_pod.dart';

import 'dashboard_repository.dart';
import 'i_dashboard_repository.dart';

final dashboardRepositoryProvider = Provider.autoDispose<IDashboardRepository>(
  (ref) => DashboardRepository(
    iDashboardApi: ref.watch(dashboardApiProvider),
  ),
);