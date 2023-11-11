import 'dart:convert';

class DeleteModel {
  final String message;
  DeleteModel({
    required this.message,
  });

  DeleteModel copyWith({
    String? message,
  }) {
    return DeleteModel(
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
    };
  }

  factory DeleteModel.fromMap(Map<String, dynamic> map) {
    return DeleteModel(
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DeleteModel.fromJson(String source) =>
      DeleteModel.fromMap(json.decode(source));

  @override
  String toString() => 'DeleteModel(message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DeleteModel && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
