import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
           print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>> URL ITEM  ${snapshot.data}");

            return Container(
              height: height,
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  
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
}