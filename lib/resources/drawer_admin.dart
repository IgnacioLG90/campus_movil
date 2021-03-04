import 'package:campusflutter/bloc/auth_b/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerAdmin extends StatefulWidget {
  DrawerAdmin();

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
    return Drawer(
      child: ListView(
        children: <Widget>[
          BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            if (state is AdminLoginSuccesState) {
              return UserAccountsDrawerHeader(
                accountName: Text(state.nombre),
                accountEmail: Text(state.email),
              );
            } else {
              return ListTile(
                title: Text("Error al cargar los datos"),
                trailing: Icon(Icons.error),
              );
            }
          }),
          ListTile(
            title: Text("Perfil"),
            trailing: Icon(Icons.edit),
            onTap: () {},
          ),
          ListTile(
            title: Text("Lista cursos"),
            trailing: Icon(Icons.admin_panel_settings),
            onTap: () {
              Navigator.pushNamed(context, '/adminC');
            },
          ),
          ListTile(
            title: Text("Lista usuarios"),
            trailing: Icon(Icons.verified_user),
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
    );
  }
}
