import 'package:campusflutter/bloc/auth_b/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Admin extends StatefulWidget {
  Admin({Key key}) : super(key: key);

  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  AuthBloc vueltaBlocAdmin;
  @override
  void initState() {
    vueltaBlocAdmin = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UserLoginSuccesState) {
            return Navigator.pushNamed(context, '/user');
          } else if (state is AdminLoginSuccesState) {
            return Navigator.pushNamed(context, '/admin');
          } else if (state is ControlPageState) {
            return Navigator.pushNamed(context, '/login');
          }
        },
        child: Container(
          child: Center(
            child: RaisedButton(
              child: Text("Cerrar Sesion de Admin"),
              onPressed: () {
                vueltaBlocAdmin.add(EliminarToken());
              },
            ),
          ),
        ),
      ),
    );
  }
}