import 'package:flutter/material.dart';

@immutable
sealed class AddUpdateItemState {
  const AddUpdateItemState();
}

class AddUpdateItemInitial implements AddUpdateItemState {
  const AddUpdateItemInitial() : super();
}

class AddUpdateItemLoading implements AddUpdateItemState {
  const AddUpdateItemLoading() : super();
}

class AddUpdateItemLoaded implements AddUpdateItemState {
  const AddUpdateItemLoaded() : super();
}
