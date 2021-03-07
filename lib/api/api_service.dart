import 'dart:convert';

import 'package:campusflutter/models/clase.dart';
import 'package:campusflutter/models/curso.dart';
import 'package:campusflutter/models/usuario.dart';
import 'package:campusflutter/models/usuario_list.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = "http://192.168.56.1:3000";

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

  Future<List<Curso>> getUsuarioPopulate(String id) async {
    http.Response res = await http.get("$apiUrl/usuarios/usuariosMovil/$id");
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Curso> cursos =
          body.map((dynamic item) => Curso.fromJson(item)).toList();
      return cursos;
    } else {
      print(res);
      throw "Error al cargar el usuario";
    }
  }

  Future<List<Curso>> getAllCursos() async {
    http.Response res = await http.get("$apiUrl/cursos/cursosMovil");

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Curso> cursos =
          body.map((dynamic item) => Curso.fromJson(item)).toList();
      return cursos;
    } else {
      throw "Error en la lista de Cursos";
    }
  }

  Future<List<UsuarioList>> getAllAlumnos() async {
    http.Response res = await http.get("$apiUrl/usuarios/alumno");

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<UsuarioList> usuarios =
          body.map((dynamic item) => UsuarioList.fromJson(item)).toList();
      return usuarios;
    } else {
      throw "Error en la lista de Alumnos";
    }
  }

  Future<List<UsuarioList>> getAllProfesores() async {
    http.Response res = await http.get("$apiUrl/usuarios/profesor");

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<UsuarioList> usuarios =
          body.map((dynamic item) => UsuarioList.fromJson(item)).toList();
      return usuarios;
    } else {
      throw "Error en la lista de Profesores";
    }
  }

  Future<List<Clase>> getAllClases(String id) async {
    http.Response res = await http.get("$apiUrl/cursos/cursoPopMovil/$id");

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Clase> clases =
          body.map((dynamic item) => Clase.fromJson(item)).toList();
      return clases;
    } else {
      throw "Error en la lista de Clases";
    }
  }
}
