part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class LoginInitialState extends AuthState {}

class UserLoginSuccesState extends AuthState {}

class AdminLoginSuccesState extends AuthState {}

class LoginLoadinState extends AuthState {}

class LoginErrorState extends AuthState {
  final String message;
  LoginErrorState({this.message});
}

class ControlPageState extends AuthState {}
