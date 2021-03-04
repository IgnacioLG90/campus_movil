import 'package:campusflutter/bloc/auth_b/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerUser extends StatefulWidget {
  final String nombre;
  final String email;
  DrawerUser({this.email, this.nombre});

  @override
  _DrawerUserState createState() => _DrawerUserState();
}

class _DrawerUserState extends State<DrawerUser> {
  AuthBloc deslogUser;

  @override
  void initState() {
    deslogUser = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          // UserAccountsDrawerHeader(
          //     accountName: Text(widget.nombre),
          //     accountEmail: Text(widget.email),
          // ),
          ListTile(
            title: Text("Perfil"),
            trailing: Icon(Icons.edit),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            title: Text("Log out"),
            trailing: Icon(Icons.exit_to_app),
            onTap: () {
              deslogUser.add(EliminarToken());
            },
          )
        ],
      ),
    );
  }
}
