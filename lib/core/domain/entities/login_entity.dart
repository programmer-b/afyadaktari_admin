import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final String password;
  final String username;

  const LoginEntity(this.password, this.username);

  @override
  List<Object?> get props => [password,username];
}