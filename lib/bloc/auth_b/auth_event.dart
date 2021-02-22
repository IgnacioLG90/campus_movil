part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class StartEvent extends AuthEvent {}

class LoginButtonPress extends AuthEvent {
  final String email;
  final String password;

  LoginButtonPress({this.email, this.password});
}

class ComprobarPaginas extends AuthEvent {}

class EliminarToken extends AuthEvent {}
