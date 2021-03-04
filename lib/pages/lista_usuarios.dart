import 'package:campusflutter/models/usuario_list.dart';
import 'package:flutter/material.dart';

class ListaUsarios extends StatelessWidget {
  final List<UsuarioList> usuarios;
  ListaUsarios({Key key, this.usuarios}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: usuarios == null ? 0 : usuarios.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Icon(Icons.person),
          title: Text(usuarios[index].nombre),
          subtitle: Text(usuarios[index].email),
        );
      }
    );
  }
}