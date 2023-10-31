import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pokemon/blocs/bloc_api_pokemon.dart';
import 'package:pokemon/src/services/colores.dart';
import 'package:pokemon/src/services/http_v1.dart';
import 'package:pokemon/src/ulils/responsive.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController controladorBusqueda = TextEditingController();
  List items = [];


@override
  void initState() {
    // TODO: implement initState
    super.initState();

    EasyLoading.show(status: 'Cargando elementos...');
    HttpV1().pokemonAbility().then((value){
      EasyLoading.dismiss();
      items = value["results"];
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
                    title: Text("POKEAPI",
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
                        title: Text(p["name"].toString().toUpperCase(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: getColors()[0],
                              fontSize: responsive.ip(2.8),
                              fontWeight: FontWeight.bold,
                              // fontStyle: FontStyle.italic
                            ),
                          ),
                        subtitle: Text(p["url"],
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
                            onPressed: (){
                              Navigator.pushNamed(context, 'detail_of_item', arguments: {"url":  p["url"], "name": p["name"]});
                            },
                          ),
                          onTap: (){
                             Navigator.pushNamed(context, 'detail_of_item', arguments: {"url":  p["url"], "name": p["name"]});
                          },
                       )
                    );
                  }
                  return Column(
                    children: [
                      _search(height, width, responsive),
                      Column(
                        children: listWidgets,
                      ),
                    ],
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
                 return Container();
                }
              }
            )
          ),
        )
      )
      );
  }


  Widget _search(double height, double width, Responsive responsive){
   return  StreamBuilder(
    stream: blocApiPokemon.pokemonsStream,
     builder: (_, AsyncSnapshot<List> snapshot) {
      if(snapshot.hasData){
        return Container(
                  height: responsive.ip(6),
                  width: width * 0.9,
                  child: SearchBarAnimation(
                          hintText: "Buscar item",
                          textEditingController: controladorBusqueda,
                          isOriginalAnimation: true,
                          enableKeyboardFocus: true,
                          trailingWidget: Icon(Icons.search, color:  getColors()[0]),
                          secondaryButtonWidget: const Icon(Icons.close, color: Colors.black),
                          buttonWidget: Icon(Icons.search, color:  getColors()[0]),
                          onChanged: (newValue){

                            if(newValue.toString().isEmpty){
                              blocApiPokemon.changePokemons(items);
                            }else{
                              List newArrayItems = [];
                              blocApiPokemon.changePokemons(newArrayItems);
                              
                              
                              for(var p in items){
                                if(p["name"].toString().toLowerCase().contains(newValue.toString().toLowerCase())){
                                    newArrayItems.add(p);
                                }
                              }
                              blocApiPokemon.changePokemons(newArrayItems);
                            }
                        }
                      ),
                );
      }else{
        return Container(
          height: responsive.ip(6),
          width: width * 0.8,
        );
      }
     }
   );
 }
}