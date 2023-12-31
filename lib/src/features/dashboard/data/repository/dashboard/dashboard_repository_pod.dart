import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/src/features/dashboard/data/apis/dashboard/dashboard_api_pod.dart';
import 'package:foodibizz/src/features/dashboard/data/repository/dashboard/dashboard_repository.dart';
import 'package:foodibizz/src/features/dashboard/data/repository/dashboard/i_dashboard_repository.dart';



final dashboardRepositoryProvider = Provider.autoDispose<IDashboardRepository>(
  (ref) => DashboardRepository(
    iDashboardApi: ref.watch(dashboardApiProvider),
  ),
);
