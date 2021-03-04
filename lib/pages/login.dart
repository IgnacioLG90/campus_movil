import 'package:campusflutter/bloc/auth_b/auth_bloc.dart';
import 'package:campusflutter/resources/header_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _addFormKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  AuthBloc authBloc;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.add(ComprobarPaginas());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final msg = BlocBuilder<AuthBloc, AuthState>(
    //   builder: (context, state) {
    //     if (state is LoginErrorState) {
    //       return Text(state.message);
    //     } else if (state is LoginLoadinState) {
    //       return Center(child: CircularProgressIndicator());
    //     } else {
    //       return Container();
    //     }
    //   },
    // );

    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UserLoginSuccesState) {
            return Navigator.pushNamed(context, '/user');
          } else if (state is AdminLoginSuccesState) {
            return Navigator.pushNamed(context, '/adminC');
          }
        },
        child: Container(
          padding: EdgeInsets.only(bottom: 30),
          child: Column(
            children: <Widget>[
              HeaderLogin(text: "Login"),
              Expanded(
                flex: 1,
                child: Form(
                  key: _addFormKey,
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          // msg,
                          _textInput(
                              controller: email,
                              hint: "Email",
                              ocultar: false,
                              icon: Icons.email),
                          _textInput(
                              controller: password,
                              hint: "Password",
                              ocultar: true,
                              icon: Icons.vpn_key),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Forgot Password?",
                            ),
                          ),
                          Container(
                            height: 150,
                            child: Center(
                              child: RaisedButton(
                                onPressed: (){
                                  if(_addFormKey.currentState.validate()){
                                    _addFormKey.currentState.save();
                                    authBloc.add(LoginButtonPress(email: email.text, password: password.text));
                                  }
                                },
                                padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
                                color: Color(0xff0984e3),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                                child: Text(
                                  'Insertar',
                                  style: TextStyle(color: Colors.white, fontSize: 18),
                                ),
                              )
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:<Widget>[
                              Text('¿ No tienes cuenta ?', style:TextStyle(color: Colors.black)),
                              SizedBox(width:10),
                              GestureDetector(
                                onTap: (){
                                  Navigator.pushNamed(context, '/registro');
                                },
                                child: Text(
                                  'Registrate',
                                  style: TextStyle(color: Color(0xff0984e3), decoration: TextDecoration.underline),
                                )
                              )
                            ]
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _textInput({controller, hint, ocultar, icon}) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 10),
      child: TextFormField(
        controller: controller,
        obscureText: ocultar,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon),
        ),
        validator: (value){
          if(value.isEmpty){
            return 'Introduce ${hint}';
          }
          return null;
        },
        onChanged: (value) {},
      ),
    );
  }
}
