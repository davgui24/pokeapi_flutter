import 'package:dio/dio.dart';
import 'package:pokemon/enviromets/url_server.dart';


class HttpV1 {
  final String _api = urlserver.url;
  var dio = Dio();

  // ***********************************************  NOTIFICATIONS PUSH
  Future<dynamic> pokemonAbility() async {
       try {
        dio.options.headers["Content-Type"] = "multipart/form-data";
        dio.options.headers["Accept"] = "application/json";
        var response = await dio.get("$_api/ability");
        return response.data;

      } catch (e) {
        print("EL ERRROR al actualizar la sesion del usuario >>>>  ${e.toString()}");
      }
    
  }

}