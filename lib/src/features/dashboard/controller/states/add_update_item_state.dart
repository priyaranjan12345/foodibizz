sealed class AddUpdateItemState {}

class AddUpdateItemInitial implements AddUpdateItemState {}

class AddUpdateItemLoading implements AddUpdateItemState {}

class AddUpdateItemLoaded implements AddUpdateItemState {}

class AddUpdateItemError implements AddUpdateItemState {
  final String message;
  AddUpdateItemError({
    required this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddUpdateItemError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
