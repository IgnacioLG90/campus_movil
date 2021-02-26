import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:campusflutter/api/api_service.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  ApiService service;
  AuthBloc(AuthState initialState, this.service) : super(initialState);

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    var pref = await SharedPreferences.getInstance();

    if (event is StartEvent) {
      yield LoginInitialState();
    } else if (event is LoginButtonPress) {
      yield AuthInitial();
      var datos = await service.login(event.email, event.password);

      if (datos['comprobarLogin']['role'] == 'user') {
        pref.setString('token', datos['token']);
        pref.setString('role', datos['comprobarLogin']['role']);
        pref.setString('id', datos['comprobarLogin']['_id']);
        pref.setString('email', datos['comprobarLogin']['email']);
        pref.setString('nombre', datos['comprobarLogin']['nombre']);
        yield UserLoginSuccesState();
      } else if (datos['comprobarLogin']['role'] == 'admin' ||
          datos['comprobarLogin']['role'] == 'profesor') {
        pref.setString('token', datos['token']);
        pref.setString('role', datos['comprobarLogin']['role']);
        pref.setString('id', datos['comprobarLogin']['_id']);
        pref.setString('email', datos['comprobarLogin']['email']);
        pref.setString('nombre', datos['comprobarLogin']['nombre']);
        yield AdminLoginSuccesState();
      } else {
        yield LoginErrorState(message: datos['msg'][0]);
      }
    } else if (event is ComprobarPaginas) {
      if (pref.getString('token') == null) {
        yield LoginInitialState();
      } else {
        if (pref.getString('role') == 'user') {
          yield UserLoginSuccesState();
        } else if (pref.getString('role') == 'admin' ||
            pref.getString('role') == 'profesor') {
          yield AdminLoginSuccesState();
        }
      }
    } else if (event is EliminarToken) {
      pref.clear();
      yield ControlPageState();
    }
  }
}
