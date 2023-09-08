import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodibizz/global/extensions/snackbar_ext.dart';
import 'package:foodibizz/global/riverpod_ext/asyncvalue_easy_when.dart';
import '../../controller/providers/add_update_item_provider.dart';
import '../../controller/states/add_update_item_state.dart';

class SubmitItemButton extends ConsumerWidget {
  const SubmitItemButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final submitItemButtonState = ref.watch(addUpdateItemProvider);

    ref.listen(
      addUpdateItemProvider,
      (previous, next) {
        next.;
      },
    );

    return submitItemButtonState.;
  }
}
