import 'dart:convert';

import 'package:campusflutter/models/usuario.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = "http://192.168.1.127:3000";

  login(String email, String password) async {
    var respuesta = await http.post(
      "$apiUrl/login",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode({'email': email, 'password': password}),
    );

    final datos = json.decode(respuesta.body);

    if (datos['ok'] == true) {
      // print('bien');
      // print(datos);
      return datos;
    } else {
      // print('mal');
      // print(datos);
      return "Tenemos un fallo en el Servior";
    }
  }

  registro(String nombre, String email, String password) async {
    Map datos = {
      'nombre': nombre,
      'email': email,
      'password': password,
    };

    final http.Response respuesta = await http.post(
      "$apiUrl/usuarios",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(datos),
    );

    final data = json.decode(respuesta.body);

    if (data['ok'] == true) {
      // print('bien');
      // print(data);
      return "Usuario Registrado";
    } else {
      // print('mal');
      // print(data);
      return "Tenemos un fallo en el Servior";
    }
  }

  Future<Usuario> getUsuarioPopulate(String id) async {
    String myid = id;
    print("$apiUrl/usuarios/total/$myid");
    http.Response res = await http.get("$apiUrl/usuarios/total/$id");
    if (res.statusCode == 200) {
      return Usuario.fromJson(json.decode(res.body));
    } else {
      print(res);
      throw "Error al cargar el usuario";
    }
  }
}
