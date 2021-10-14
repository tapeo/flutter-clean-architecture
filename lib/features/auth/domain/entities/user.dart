import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? phone;

  const UserModel({
    this.phone,
  });

  UserModel copyWith({
    String? phone,
  }) {
    return UserModel(
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      phone: map['phone'],
    );
  }

  @override
  List<Object?> get props => [phone];
}
