import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/global/riverpod_ext/cache_ext.dart';
import 'package:foodibizz/global/riverpod_ext/cancel_ext.dart';

import '../../data/repository/dashboard/dashboard_repository_pod.dart';

class DeleteItemNotifier extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr build() {
    return future;
  }

  Future<void> onTapDelete(String id) async {
    state = const AsyncLoading();
    final token = ref.cancelToken();
    final link = ref.cacheFor();
    final result = await ref.watch(dashboardRepositoryProvider).deleteItems(
          id: id,
          cancelToken: token,
        );

    result.when(
      (success) {
        state = const AsyncData(null);
      },
      (error) {
        link.close();
        state = AsyncError(error.message, StackTrace.current);
      },
    );
  }
}
