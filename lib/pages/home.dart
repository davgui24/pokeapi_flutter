import 'package:flutter/material.dart';
import 'package:pokemon/blocs/bloc_api_pokemon.dart';
import 'package:pokemon/src/services/colores.dart';
import 'package:pokemon/src/services/http_v1.dart';
import 'package:pokemon/src/ulils/responsive.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    HttpV1().pokemonAbility().then((value){
      blocApiPokemon.changePokemons(value["results"]);
    });
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);

    
    return WillPopScope(
      onWillPop: () async {
                    return false;
                  },
      child: Scaffold(
        appBar: PreferredSize(
                  preferredSize: Size.fromHeight(responsive.ip(7)),
                  child: AppBar(
                    elevation: 0,
                    centerTitle: true,
                    backgroundColor: getColors()[0],
                    title: Text("POKEMÓN",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: responsive.ip(3),
                              fontWeight: FontWeight.bold,
                              // fontStyle: FontStyle.italic
                            ),
                          ),
                  )
              ),
        body: Container(
          height: height,
          width: width,
          child: SingleChildScrollView(
            child: StreamBuilder<List>(
              stream: blocApiPokemon.pokemonsStream,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  List<Widget> listWidgets = [];
                  for(var p in snapshot.data!){
                    listWidgets.add(
                      ListTile(
                        contentPadding: EdgeInsets.all(responsive.ip(2)),
                        title: Text('${p["name"].toString().toUpperCase()}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: getColors()[0],
                              fontSize: responsive.ip(3),
                              fontWeight: FontWeight.bold,
                              // fontStyle: FontStyle.italic
                            ),
                          ),
                        subtitle: Text('${p["url"]}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: responsive.ip(2),
                              fontWeight: FontWeight.bold,
                              // fontStyle: FontStyle.italic
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.arrow_right, color: getColors()[0], size: responsive.ip(4)),
                            onPressed: (){},
                          ),
                       )
                    );
                  }
                  return Column(
                    children: listWidgets,
                  );
                }else if(snapshot.hasError){
                  return Text("Error al obtener la lista",
                    style: TextStyle(
                      fontSize: responsive.ip(2.5),
                      fontWeight: FontWeight.w900,
                      color: Colors.red
                    )
                  );
                }else{
                 return Center(
                    child: Container(
                      margin: EdgeInsets.only(top: responsive.ip(10)),
                      child: CircularProgressIndicator(
                        color: getColors()[0],
                      ),
                    ),
                  );
                }
              }
            )
          ),
        )
      )
      );
  }
}