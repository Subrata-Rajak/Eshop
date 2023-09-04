import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String message;
  final String token;
  final UserInfo userInfo;

  const UserEntity({
    required this.message,
    required this.token,
    required this.userInfo,
  });

  @override
  List<Object?> get props => [
        message,
        token,
        userInfo,
      ];
}

class UserInfo extends Equatable {
  final String name;
  final String email;
  final String password;
  final String gender;
  final String phone;
  final String id;
  final int v;

  const UserInfo({
    required this.name,
    required this.email,
    required this.password,
    required this.gender,
    required this.phone,
    required this.id,
    required this.v,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        password,
        gender,
        phone,
        id,
        v,
      ];
}
