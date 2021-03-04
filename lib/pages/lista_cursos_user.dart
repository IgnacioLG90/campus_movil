import 'package:campusflutter/models/curso.dart';
import 'package:flutter/material.dart';

class ListaCursosUser extends StatelessWidget {
  final List<Curso> cursos;
  ListaCursosUser({Key key, this.cursos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: cursos == null ? 0 : cursos.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 200,
          margin: EdgeInsets.only(bottom: 15),
          child: InkWell(
            onTap: () {},
            child: Center(
              child: Text(cursos[index].titulo),
            ),
          ),
        );
      },
    );
  }
}
