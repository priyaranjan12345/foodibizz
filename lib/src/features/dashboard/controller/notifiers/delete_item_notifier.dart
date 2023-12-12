import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/global/riverpod_ext/cancel_ext.dart';
import 'package:foodibizz/src/features/dashboard/data/repository/dashboard/dashboard_repository_pod.dart';

class DeleteItemNotifier extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr build() {
    state = const AsyncData(null);
    return future;
  }

  Future<void> onTapDelete(String id) async {
    state = const AsyncLoading();

    Future.delayed(const Duration(seconds: 3));

    final result = await ref.watch(dashboardRepositoryProvider).deleteItems(
          id: id,
          cancelToken: ref.cancelToken(),
        );

    result.when(
      (success) {
        state = const AsyncData(null);
      },
      (error) {
        state = AsyncError(
          error.errorMessage ?? "Error on delete",
          StackTrace.current,
        );
      },
    );
  }
}
