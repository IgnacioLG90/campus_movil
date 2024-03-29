import 'package:campusflutter/api/api_service.dart';
import 'package:campusflutter/bloc/auth_b/auth_bloc.dart';
import 'package:campusflutter/pages/admin.dart';
import 'package:campusflutter/pages/admin_p.dart';
import 'package:campusflutter/pages/admin_u.dart';
import 'package:campusflutter/pages/login.dart';
import 'package:campusflutter/pages/pagina_carga.dart';
import 'package:campusflutter/pages/registro.dart';
import 'package:campusflutter/pages/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(AuthInitial(), ApiService()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => PaginaCarga(),
          '/login': (context) => Login(),
          '/registro': (context) => Registro(),
          '/user': (context) => User(),
          '/adminC': (context) => Admin(),
          '/adminU': (context) => AdminU(),
          '/adminP': (context) => AdminP(),
        },
      ),
    );
  }
}
