import 'package:campusflutter/api/api_service.dart';
import 'package:campusflutter/resources/header_login.dart';
import 'package:flutter/material.dart';

class Registro extends StatefulWidget {
  Registro({Key key}) : super(key: key);

  @override
  _RegistroState createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  final ApiService api = ApiService();
  final _addFormKey = GlobalKey<FormState>();
  final nombre = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(
          padding: EdgeInsets.only(bottom: 30),
          child: Column(
            children: <Widget>[
              HeaderLogin(text: "Registro"),
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
                          _textInput(
                              controller: nombre,
                              hint: "Nombre",
                              ocultar: false,
                              icon: Icons.person),
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
                            height: 150,
                            child: Center(
                              child: RaisedButton(
                                onPressed: (){
                                   if(_addFormKey.currentState.validate()){
                                     _addFormKey.currentState.save();
                                     api.registro(nombre.text, email.text, password.text);
                                     Navigator.pushNamed(context, '/login');
                                   }
                                },
                                padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
                                color: Color(0xff0984e3),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                                child: Text(
                                  'Registrarse',
                                  style: TextStyle(color: Colors.white, fontSize: 18),
                                ),
                              )
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:<Widget>[
                              Text('¿ Ya tienes cuenta ?', style:TextStyle(color: Colors.black)),
                              SizedBox(width:10),
                              GestureDetector(
                                onTap: (){
                                  Navigator.pushNamed(context, '/login');
                                },
                                child: Text(
                                  'Logeate',
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
    );
  }
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
