import 'package:campusflutter/api/api_service.dart';
import 'package:campusflutter/bloc/auth_b/auth_bloc.dart';
import 'package:campusflutter/models/curso.dart';
import 'package:campusflutter/resources/lista_cursos_user.dart';
import 'package:campusflutter/resources/drawer_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class User extends StatefulWidget {
  User({this.id});
  final String id;

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  final ApiService api = ApiService();
  Future<List<Curso>> cursosList;
  AuthBloc vueltaBloc;
  String id;

  @override
  void initState() {
    vueltaBloc = BlocProvider.of<AuthBloc>(context);
    cursosList = api.getUsuarioPopulate(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exoformacion'),
      ),
      drawer: DrawerUser(),
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
          child: FutureBuilder<List<Curso>>(
            future: cursosList,
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return ListaCursosUser(cursos: snapshot.data);
              } else if(snapshot.hasData == null){
                return Center(child: Text('No existen Datos, Añade uno'),);
              } else if(snapshot.hasError){
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Text('${snapshot.error}'),
                  ));
              }

              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  // Future loadList() {
  //   Future<List<Curso>> futureCase =
  //       api.getUsuarioPopulate("601269e995f29931009994a3");
  //   futureCase.then((cursosList) {
  //     setState(() {
  //       this.cursosList = cursosList;
  //     });
  //   });
  // }
}
