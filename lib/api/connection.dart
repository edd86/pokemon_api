import 'package:dio/dio.dart';
import 'package:pokemon_api/models/pokemon.dart';
import 'package:pokemon_api/models/result.dart';

class ApiConnection {

  Future<Result> getElements() async {
    Dio dio = Dio();
    Response response = await dio.get('https://pokeapi.co/api/v2/pokemon/');
    Result result = Result.fromJson(response.data);
    return result;
  }

  Future<Result> getElementsByRoute(String route) async {
    Dio dio = Dio();
    Response response = await dio.get(route);
    Result result = Result.fromJson(response.data);
    return result;
  }

  Future<Pokemon> getPokemon(String pokemonName) async {
    Dio dio = Dio();
    Response response = await dio.get('https://pokeapi.co/api/v2/pokemon/$pokemonName');
    return Pokemon.fromJson(response.data);
  }

}
