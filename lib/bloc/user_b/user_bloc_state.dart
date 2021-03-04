part of 'user_bloc_bloc.dart';

@immutable
abstract class UsuariosState {}

class UsuariosInitial extends UsuariosState {}

class LoadedUsers extends UsuariosState {
  final List<UsuarioList> userList;
  LoadedUsers({this.userList});
  List<Object> get props => [this.userList];
}

class ErrorState extends UsuariosState {
  final String mensaje;
  ErrorState({this.mensaje});
  List<Object> get props => [this.mensaje];
}