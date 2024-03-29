import 'package:campusflutter/api/api_service.dart';
import 'package:campusflutter/bloc/auth_b/auth_bloc.dart';
import 'package:campusflutter/models/curso.dart';
import 'package:campusflutter/resources/lista_cursos_admin.dart';
import 'package:campusflutter/pages/user.dart';
import 'package:campusflutter/resources/drawer_admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Admin extends StatefulWidget {
  Admin({Key key}) : super(key: key);

  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  final ApiService api = ApiService();
  AuthBloc vueltaBlocAdmin;
  List<Curso> cursosList;

  @override
  void initState() {
    vueltaBlocAdmin = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (cursosList == null) {
      cursosList = List<Curso>();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Lista de cursos'),
      ),
      drawer: DrawerAdmin(),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UserLoginSuccesState) {
            return Navigator.push(context, MaterialPageRoute(builder: (context) => User(id: state.id)));
          } else if (state is AdminLoginSuccesState) {
            return Navigator.pushNamed(context, '/adminC');
          } else if (state is ControlPageState) {
            return Navigator.pushNamed(context, '/login');
          }
        },
        child: Container(
          child: FutureBuilder(
            future: loadList(),
            builder: (context, snapshot) {
              return cursosList.length > 0
                  ? ListaCursosAdmin(cursos: cursosList)
                  : Center(
                      child: Text('No existen Datos, Añade uno'),
                    );
            },
          ),
        ),
      ),
    );
  }

  Future loadList() {
    Future<List<Curso>> futureCase = api.getAllCursos();
    futureCase.then((cursosList) {
      setState(() {
        this.cursosList = cursosList;
      });
    });
  }
}
