import 'package:campusflutter/api/api_service.dart';
import 'package:campusflutter/bloc/auth_b/auth_bloc.dart';
import 'package:campusflutter/models/curso.dart';
import 'package:campusflutter/models/usuario.dart';
import 'package:campusflutter/pages/lista_cursos_user.dart';
import 'package:campusflutter/resources/drawer_admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User extends StatefulWidget {
  User({Key key}) : super(key: key);

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  final ApiService api = ApiService();
  List<Curso> cursosList;
  AuthBloc vueltaBloc;
  SharedPreferences datos;
  String email;
  String nombre;
  String id;

  @override
  void initState() {
    vueltaBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
    cargarUsuario();
    checkLogin();
  }

  checkLogin() async {
    datos = await SharedPreferences.getInstance();
    email = datos.getString('email');
    nombre = datos.getString('nombre');
    id = datos.getString('id');
  }

  @override
  Widget build(BuildContext context) {
    if (cursosList == null) {
      cursosList = List<Curso>();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Exoformacion'),
      ),
      drawer: DrawerAdmin(email: this.email, nombre: this.nombre),
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
          child: FutureBuilder(
            future: cargarUsuario(),
            builder: (context, snapshot) {
              return cursosList.length > 0
                  ? ListaCursosUser(cursos: cursosList)
                  : Center(
                      child: Text('No existen Datos, Añade uno'),
                    );
            },
          ),
        ),
      ),
    );
  }

  Future cargarUsuario() {
    Future<Usuario> user = api.getUsuarioPopulate(this.id);
    user.then((resp) {
      setState(() {
        this.cursosList = resp.cursos;
      });
    });
  }
}
