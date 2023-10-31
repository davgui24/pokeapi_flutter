import 'dart:async';
import 'package:rxdart/rxdart.dart';

class BlocApiPokemon {
  var _pokemonsController = BehaviorSubject<List>();


  //  RECUPERAR LOS DAOS DEL STREAM
  Stream<List> get pokemonsStream =>  _pokemonsController.stream;

  //  INSERTAR VALORES AL STREAM
  Function(List) get changePokemons=> _pokemonsController.sink.add;

  // OBTENER LOS VALORES DE EL EMAIL Y PASSWORD
  List? get pokemons => _pokemonsController.value;

  dispose() {
    _pokemonsController.close();
  }
}

BlocApiPokemon blocApiPokemon = BlocApiPokemon();
