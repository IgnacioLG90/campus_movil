import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  login(String email, String password) async {
    var respuesta = await http.post(
      "http://192.168.56.1:3000/login",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode({'email': email, 'password': password}),
    );

    final datos = json.decode(respuesta.body);

    if (datos['ok'] == true) {
      print('bien');
      print(datos);
      return datos;
    } else {
      print('mal');
      print(datos);
      return "Tenemos un fallo en el Servior";
    }
  }

  registro(String nombre, String email, String password) async {
    Map datos = {
      'nombre': nombre,
      'email': email,
      'password': password
    };

    final http.Response respuesta = await http.post(
      "http://192.168.56.1:3000/usuarios",
      headers: <String, String> {
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(datos),
    );

    final data = json.decode(respuesta.body);

    if (data['ok'] == true) {
      print('bien');
      print(data);
      return "Usuario Registrado";
    } else {
      print('mal');
      print(data);
      return "Tenemos un fallo en el Servior";
    }
  }
}
