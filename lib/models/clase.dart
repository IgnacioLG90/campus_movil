class Clase {
    Clase({
        this.id,
        this.nombre,
        this.temas,
    });

    String id;
    String nombre;
    List<Tema> temas;

    factory Clase.fromJson(Map<String, dynamic> json) => Clase(
        id: json["_id"],
        nombre: json["nombre"],
        temas: List<Tema>.from(json["temas"].map((x) => Tema.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": nombre,
        "temas": List<dynamic>.from(temas.map((x) => x.toJson())),
    };
}

class Tema {
    Tema({
        this.id,
        this.nombreTema,
        this.link,
        this.detalle,
    });

    String id;
    String nombreTema;
    String link;
    String detalle;

    factory Tema.fromJson(Map<String, dynamic> json) => Tema(
        id: json["_id"],
        nombreTema: json["nombreTema"],
        link: json["link"],
        detalle: json["detalle"] == null ? null : json["detalle"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "nombreTema": nombreTema,
        "link": link,
        "detalle": detalle == null ? null : detalle,
    };
}