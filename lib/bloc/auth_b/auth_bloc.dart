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
      var img;
      if (datos['comprobarLogin']['role'] == 'user') {
        pref.setString('token', datos['token']);
        pref.setString('role', datos['comprobarLogin']['role']);
        pref.setString('id', datos['comprobarLogin']['_id']);
        pref.setString('nombre', datos['comprobarLogin']['nombre']);
        pref.setString('email', datos['comprobarLogin']['email']);

        if (datos['comprobarLogin']['img'] == null) {
          pref.setString('img', "assets/imagen/default.jpg");
          img = "assets/imagen/default.jpg";
        } else {
          pref.setString('img',
              "http://192.168.1.127:3000/img/${datos['comprobarLogin']['img']}");
          img =
              "http://192.168.1.127:3000/img/${datos['comprobarLogin']['img']}";
        }
        yield UserLoginSuccesState(
          id: datos['comprobarLogin']['_id'],
          nombre: datos['comprobarLogin']['nombre'],
          email: datos['comprobarLogin']['email'],
          img: img,
        );
      } else if (datos['comprobarLogin']['role'] == 'admin' ||
          datos['comprobarLogin']['role'] == 'profesor') {
        pref.setString('token', datos['token']);
        pref.setString('role', datos['comprobarLogin']['role']);
        pref.setString('id', datos['comprobarLogin']['_id']);
        pref.setString('nombre', datos['comprobarLogin']['nombre']);
        pref.setString('email', datos['comprobarLogin']['email']);
        if (datos['comprobarLogin']['img'] == null) {
          pref.setString('img', "assets/imagen/default.jpg");
          img = "assets/imagen/default.jpg";
        } else {
          pref.setString('img',
              "http://192.168.1.127:3000/img/${datos['comprobarLogin']['img']}");
          img =
              "http://192.168.1.127:3000/img/${datos['comprobarLogin']['img']}";
        }
        yield AdminLoginSuccesState(
          id: datos['comprobarLogin']['_id'],
          nombre: datos['comprobarLogin']['nombre'],
          email: datos['comprobarLogin']['email'],
          img: img,
        );
      } else {
        yield LoginErrorState(message: datos['msg'][0]);
      }
    } else if (event is ComprobarPaginas) {
      if (pref.getString('token') == null) {
        yield LoginInitialState();
      } else {
        if (pref.getString('role') == 'user') {
          yield UserLoginSuccesState(
            id: pref.getString('id'),
            nombre: pref.getString('nombre'),
            email: pref.getString('email'),
            img: pref.getString('img'),
          );
        } else if (pref.getString('role') == 'admin' ||
            pref.getString('role') == 'profesor') {
          yield AdminLoginSuccesState(
            id: pref.getString('id'),
            nombre: pref.getString('nombre'),
            email: pref.getString('email'),
            img: pref.getString('img'),
          );
        }
      }
    } else if (event is EliminarToken) {
      pref.clear();
      yield ControlPageState();
    }
  }
}
