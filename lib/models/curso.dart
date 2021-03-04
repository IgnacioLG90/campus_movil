import 'dart:convert';

class Curso {
  Curso({
    this.id,
    this.imagen,
    this.titulo,
    this.descripcion,
    this.precio,
    this.tiempo,
  });

  String id;
  String imagen;
  String titulo;
  String descripcion;
  int precio;
  int tiempo;

  factory Curso.fromJson(Map<String, dynamic> json) => Curso(
        id: json["_id"],
        imagen: json["imagen"],
        titulo: json["titulo"],
        descripcion: json["descripcion"],
        precio: json["precio"],
        tiempo: json["tiempo"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "imagen": imagen,
        "titulo": titulo,
        "descripcion": descripcion,
        "precio": precio,
        "tiempo": tiempo,
      };
}
