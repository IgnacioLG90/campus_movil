import 'package:campusflutter/api/api_service.dart';
import 'package:campusflutter/models/clase.dart';
import 'package:campusflutter/pages/video.dart';
import 'package:flutter/material.dart';

class Temario extends StatefulWidget {
  Temario({Key key, this.id}) : super(key: key);
  final String id;

  @override
  _TemarioState createState() => _TemarioState();
}

class _TemarioState extends State<Temario> {
  Future<List<Clase>> clases;
  ApiService api = ApiService();

  @override
  void initState() {
    clases = api.getAllClases(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: Text('Lista de Clases'),),
       body: Container(
        //padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        color: Colors.black87,
        child: (clases == null) 
          ? Center(child: Text("No hay clases disponibles", style: TextStyle(color: Colors.white)),)
          : FutureBuilder<List<Clase>>(
              future: clases,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return ListView.builder(
                    itemCount: snapshot.data == null ? 0 : snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Column(children: <Widget>[
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: Text(snapshot.data[index].nombre, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white54, fontSize: 14),),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  for ( var i  in snapshot.data[index].temas )
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Video(link: i.link, detalle: i.detalle,)));
                                    },
                                    child: ListTile(
                                      title: Text(i.nombreTema, style: TextStyle(color: Colors.white)),
                                      trailing: Icon(Icons.arrow_forward, color: Colors.white ,),
                                    ),
                                  ),
                                ],
                              )
                            ),
                          ],
                        ),
                      );
                    }
                  );
                } else if(snapshot.hasError){
                  return Center(child: Text("${snapshot.error}"));
                }

                return Center(child: CircularProgressIndicator());
              }
            )
       ),
    );
  }
}