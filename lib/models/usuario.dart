import 'package:campusflutter/models/curso.dart';

class Usuario {
  Usuario({
    this.role,
    this.cursos,
    this.id,
    this.nombre,
    this.email,
    this.password,
  });

  String role;
  List<Curso> cursos;
  String id;
  String nombre;
  String email;
  String password;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        role: json["role"],
        cursos: List<Curso>.from(json["cursos"].map((x) => Curso.fromJson(x))),
        id: json["_id"],
        nombre: json["nombre"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "role": role,
        "cursos": List<dynamic>.from(cursos.map((x) => x.toJson())),
        "_id": id,
        "nombre": nombre,
        "email": email,
        "password": password,
      };
}
