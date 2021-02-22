import 'package:campusflutter/bloc/auth_b/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class User extends StatefulWidget {
  User({Key key}) : super(key: key);

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  AuthBloc vueltaBloc;

  @override
  void initState() {
    vueltaBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: Text("Cerrar Sesion de Usuario"),
              onPressed: () {
                vueltaBloc.add(EliminarToken());
              },
            ),
          ),
        ),
      ),
    );
  }
}
