import 'package:campusflutter/bloc/auth_b/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerUser extends StatefulWidget {
  DrawerUser();

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
          BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            if (state is UserLoginSuccesState) {
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
