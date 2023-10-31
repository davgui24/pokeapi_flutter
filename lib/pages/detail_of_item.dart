import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_json_view/flutter_json_view.dart';
import 'package:pokemon/src/services/colores.dart';
import 'package:pokemon/src/services/http_v1.dart';
import 'package:pokemon/src/ulils/responsive.dart';

class DetailOfItem extends StatelessWidget {
  const DetailOfItem({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);

    final  data = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as dynamic;

    EasyLoading.show(status: 'Espere un momento...');

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(responsive.ip(7)),
        child: AppBar(
          elevation: 0,
              centerTitle: true,
              backgroundColor: getColors()[0],
              title: Text(data["name"],
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: responsive.ip(2.5),
                  fontWeight: FontWeight.bold,
                  // fontStyle: FontStyle.italic
                ),
              ),
              leading: CupertinoButton(
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back, color: Colors.white)
              )
        ),
      ),
      body: FutureBuilder<dynamic>(
        future: HttpV1().detailItem(url: data["url"]),
        builder: (context, snapshot) {

          if(snapshot.hasData){
            EasyLoading.dismiss();

            print(snapshot.data["effect_entries"].toString());
            List<Widget> listEffects = [];
            
            for(var e in snapshot.data["effect_entries"]){
              listEffects.add(
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: width * 0.2,
                      child: Text("Effect: ",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: getColors()[0],
                          fontSize: responsive.ip(2),
                          fontWeight: FontWeight.bold,
                          // fontStyle: FontStyle.italic
                        ),
                      ),
                    ),
                    Container(
                      width: width * 0.7,
                      child: Expanded(
                        child: Text(e["effect"],
                          textAlign: TextAlign.start,
                          style: TextStyle(
                             color: getColors()[0],
                            fontSize: responsive.ip(1.5),
                            fontWeight: FontWeight.bold,
                            // fontStyle: FontStyle.italic
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              );
            }


            return Container(
              height: height,
              width: width,
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                    width: width * 0.9,
                    height: height * 0.2,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: listEffects,
                      ),
                    ),
                  ),
                   Divider(
                    color: getColors()[0],
                    indent: 10,
                   ),
                  _tablePokemon(height, width, responsive, snapshot.data["pokemon"]),
                ],
              ),
            );
          }else if(snapshot.hasError){
            EasyLoading.dismiss();
            return Text("Error al obtener elemento",
              style: TextStyle(
                fontSize: responsive.ip(2.5),
                fontWeight: FontWeight.w900,
                color: Colors.red
              )
            );
          }else{
            return Container();
          }
        }
      ),
    );;
  }



  Widget _tablePokemon(double height, double width, Responsive responsive, List pokemons){

    List<DataRow> dataRoww = [];

    for(var a in pokemons){
        dataRoww.add(DataRow(
            selected: true,
            cells: [
              DataCell(Text(a["pokemon"]["name"])),
              DataCell(Text(a["pokemon"]["url"])),
          ])
        );
      }

    return Container(
              height: height * 0.62,
              width: width,
                child: SingleChildScrollView(
                child: DataTable(
                    columnSpacing: 3,
                    horizontalMargin: 12,
                    columns: [
                      DataColumn(
                        label: Text('Nombre',style: TextStyle(color: Color(0xff999999), fontSize: responsive.ip(2), fontWeight: FontWeight.w600)),
                      ),
                      DataColumn(
                        label: Text('URL',style: TextStyle(color: Color(0xff999999), fontSize: responsive.ip(2), fontWeight: FontWeight.w600)),
                      )
                    ],
                    rows: dataRoww
        ),
      ),
    );
  }
}