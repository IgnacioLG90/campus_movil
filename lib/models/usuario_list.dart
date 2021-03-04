class UsuarioList {
  UsuarioList({
    this.role,
    this.id,
    this.nombre,
    this.email,
    this.password,
    this.img,
  });

  String role;
  String id;
  String nombre;
  String email;
  String password;
  String img;

  factory UsuarioList.fromJson(Map<String, dynamic> json) => UsuarioList(
        role: json["role"],
        id: json["_id"],
        nombre: json["nombre"],
        email: json["email"],
        password: json["password"],
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "role": role,
        "_id": id,
        "nombre": nombre,
        "email": email,
        "password": password,
        "img": img,
      };
}
