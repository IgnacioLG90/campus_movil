import 'dart:convert';

import 'package:campusflutter/models/curso.dart';
import 'package:campusflutter/models/usuario.dart';
import 'package:campusflutter/models/usuario_list.dart';
import 'package:http/http.dart' as http;
import 'package:query_params/query_params.dart';

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

  Future<Usuario> getUsuarioPopulate(String id) async {
    String myid = id;
    print("$apiUrl/usuarios/total/$myid");

    http.Response res = await http.get("$apiUrl/usuarios/total/$myid");
    if (res.statusCode == 200) {
      return Usuario.fromJson(json.decode(res.body));
    } else {
      print(res);
      throw "Error al cargar el usuario";
    }
  }

  Future<List<Curso>> getAllCursos() async {
    http.Response res = await http.get("$apiUrl/cursos/cursosMovil");

    if(res.statusCode == 200){
      List<dynamic> body = jsonDecode(res.body);
      List<Curso> cursos = body.map((dynamic item) => Curso.fromJson(item)).toList();
      return cursos;
    } else {
      throw "Error en la lista de Cursos";
    }
  }

  Future<List<UsuarioList>> getAllUsers() async {
    http.Response res = await http.get("$apiUrl/usuarios/usuariosMovil");

    if(res.statusCode == 200){
      List<dynamic> body = jsonDecode(res.body);
      List<UsuarioList> usuarios = body.map((dynamic item) => UsuarioList.fromJson(item)).toList();
      return usuarios;
    } else {
      throw "Error en la lista de Usuarios";
    }
  }

  Future<List<UsuarioList>> getUsersPag(URLQueryParams queryParams) async {
    try {
      http.Response response = await http.get(
          '$apiUrl/usuarios/paginasM?${queryParams.toString()}');

      List<dynamic> list = jsonDecode(response.body);
      List<UsuarioList> userList = [];
      list.map((datos) => userList.add(UsuarioList.fromJson(datos))).toList();
      return userList.length == 0 ? null : userList;
    } catch (err) {
      return null;
    }
  }

  

}
