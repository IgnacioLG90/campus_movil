import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  login(String email, String password) async {
    var respuesta = await http.post(
      "http://192.168.1.127:3000/login",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode({'email': email, 'password': password}),
    );

    final datos = json.decode(respuesta.body);

    if (datos['ok'] == true) {
      print(datos);
      return datos;
    } else {
      print(datos);
      return "Tenemos un fallo en el Servior";
    }
  }
}
