import 'package:campusflutter/bloc/auth_b/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerAdmin extends StatefulWidget {
  final String nombre;
  final String email;
  DrawerAdmin({this.email, this.nombre});

  @override
  _DrawerAdminState createState() => _DrawerAdminState();
}

class _DrawerAdminState extends State<DrawerAdmin> {
  AuthBloc deslogAdmin;

  @override
  void initState() {
    deslogAdmin = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return Container(
       child: Drawer(
      child: ListView(
        children: <Widget>[
          // UserAccountsDrawerHeader(
          //    accountName: Text(widget.nombre),
          //    accountEmail: Text(widget.email),
          // ),
          ListTile(
            title: Text("Perfil"),
            trailing: Icon(Icons.edit),
            onTap: () {},
          ),
          ListTile(
            title: Text("Lista cursos"),
            trailing: Icon(Icons.edit),
            onTap: () {
              Navigator.pushNamed(context, '/adminC');
            },
          ),
          ListTile(
            title: Text("Lista usuarios"),
            trailing: Icon(Icons.edit),
            onTap: () {
              Navigator.pushNamed(context, '/adminU');
            },
          ),
          Divider(),
          ListTile(
            title: Text("Log out"),
            trailing: Icon(Icons.exit_to_app),
            onTap: () {
              deslogAdmin.add(EliminarToken());
            },
          )
        ],
      ),
    )
    );
  }
}