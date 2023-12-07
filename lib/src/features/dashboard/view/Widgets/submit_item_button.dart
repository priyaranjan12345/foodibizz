import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/global/extensions/snackbar_ext.dart';
import 'package:foodibizz/global/riverpod_ext/asyncvalue_easy_when.dart';
import '../../controller/providers/add_update_item_provider.dart';
import '../../controller/states/add_update_item_state.dart';

class SubmitItemButton extends ConsumerWidget {
  const SubmitItemButton({
    super.key,
    this.buttonDisabled = false,
    required this.onSubmit,
  });

  final VoidCallback onSubmit;
  final bool buttonDisabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final submitItemButtonState = ref.watch(addUpdateItemProvider);

    ref.listen(
      addUpdateItemProvider,
      (previous, next) {
        next.when(
          data: (data) => switch (data) {
            AddUpdateItemInitial() => null,
            AddUpdateItemLoading() => null,
            AddUpdateItemLoaded() => context.popRoute(1),
          },
          error: (e, _) {
            /// show error snackbar
            final snackBar = SnackBar(content: Text("Error: ${e.toString()}"));
            context.showSnackBar(snackBar);
          },
          loading: () {
            // show loading dialog
          },
        );
      },
    );

    return submitItemButtonState.easyWhen(
      data: (data) {
        return switch (data) {
          AddUpdateItemInitial() => ElevatedButton(
              onPressed: buttonDisabled ? null : onSubmit,
              child: const Text("Submit"),
            ),
          AddUpdateItemLoading() => const ElevatedButton(
              onPressed: null,
              child: Text("Submit"),
            ),
          AddUpdateItemLoaded() => const ElevatedButton(
              onPressed: null,
              child: Text("Submit"),
            ),
        };
      },
      errorWidget: (error, stackTrace) => ElevatedButton(
        onPressed: buttonDisabled ? null : onSubmit,
        child: const Text("Retry"),
      ),
      loadingWidget: () => const ElevatedButton(
        onPressed: null,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
