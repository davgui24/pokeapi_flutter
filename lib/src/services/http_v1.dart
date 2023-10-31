import 'package:dio/dio.dart';
import 'package:pokemon/enviromets/url_server.dart';


class HttpV1 {
  final String _api = urlserver.url;
  var dio = Dio();

  Future<dynamic> pokemonAbility() async {
       try {
        dio.options.headers["Content-Type"] = "multipart/form-data";
        dio.options.headers["Accept"] = "application/json";
        var response = await dio.get("$_api/ability");
        return response.data;

      } catch (e) {
        print("EL ERRROR  >>>>  ${e.toString()}");
      }
  }


  Future<dynamic> detailItem({required String url}) async {
       try {
        dio.options.headers["Content-Type"] = "multipart/form-data";
        dio.options.headers["Accept"] = "application/json";
        var response = await dio.get(url);
        return response.data;

      } catch (e) {
        print("EL ERRROR >>>>  ${e.toString()}");
      }
  }

}