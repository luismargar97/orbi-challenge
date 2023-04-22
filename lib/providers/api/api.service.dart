import 'package:orbi_challenge/models/pokemon_detail/pokemon.detail.model.dart';
import 'package:orbi_challenge/models/pokemon_list/pokemon.list.model.dart';
import 'package:orbi_challenge/providers/api/api.config.dart';

class ApiService {
  static ApiService? _instance;

  ApiService._();

  factory ApiService() {
    return _instance ??= ApiService._();
  }

  static final _api = Api();

  final String url = 'https://pokeapi.co/api/v2';

  Future<PokemonList> getPokemons({int limit = 25, int offset = 0}) async {
    try {
      final response = await _api.dio.get('$url/pokemon?limit=$limit&offset=$offset');

      return PokemonList.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Pokemon> getPokemon(String name) async {
    try {
      final response = await _api.dio.get('$url/pokemon/$name');

      return Pokemon.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Specie> getPokemonSpecie(int id) async {
    try {
      final response = await _api.dio.get('$url/pokemon-species/$id');

      return Specie.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
