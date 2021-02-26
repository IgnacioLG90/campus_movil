class Curso {
  Curso({
    this.id,
    this.titulo,
    this.descripcion,
    this.precio,
    this.tiempo,
  });

  String id;
  String titulo;
  String descripcion;
  int precio;
  int tiempo;

  factory Curso.fromJson(Map<String, dynamic> json) => Curso(
        id: json["_id"],
        titulo: json["titulo"],
        descripcion: json["descripcion"],
        precio: json["precio"],
        tiempo: json["tiempo"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "titulo": titulo,
        "descripcion": descripcion,
        "precio": precio,
        "tiempo": tiempo,
      };
}
