part of 'user_bloc_bloc.dart';

@immutable
abstract class UsuariosEvent {}

class FetchUsuarios extends UsuariosEvent {
  FetchUsuarios();
}
