part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class LoginInitialState extends AuthState {}

class UserLoginSuccesState extends AuthState {
  final String id;
  final String nombre;
  final String email;
  final String img;
  UserLoginSuccesState({this.id, this.nombre, this.email, this.img});
}

class AdminLoginSuccesState extends AuthState {
  final String id;
  final String nombre;
  final String email;
  final String img;
  AdminLoginSuccesState({this.id, this.nombre, this.email, this.img});
}

class LoginLoadinState extends AuthState {}

class LoginErrorState extends AuthState {
  final String message;
  LoginErrorState({this.message});
}

class ControlPageState extends AuthState {}
