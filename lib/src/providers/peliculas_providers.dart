import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movies_app/src/models/pelicula_model.dart';

class PeliculasProvider {

  String _apiKey  = '2b6d0b2939b66f522ecd1a5d7f2d5d34';
  String _url     = 'api.themoviedb.org';
  String _language = 'es-ES';


  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key'  :  _apiKey,
      'lenguage' :  _language
    });

    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final peliculas = new Peliculas.fromJsonList(decodeData['results']);

    return peliculas.items;
  }

}