import 'package:orbi_challenge/models/pokemon_detail/pokemon.detail.model.dart';
import 'package:orbi_challenge/models/pokemon_list/pokemon.list.model.dart';
import 'package:orbi_challenge/providers/api/api.service.dart';
import 'package:orbi_challenge/utils/extensions.dart';

class PokemonsService {
  static final PokemonsService _singleton = PokemonsService._internal();

  factory PokemonsService() {
    return _singleton;
  }

  PokemonsService._internal();

  final ApiService _apiService = ApiService();

  List<Pokemon> pokemonsLoaded = [];
  int page = 0;
  final int offset = 25;

  Future<List<Pokemon>> getPokemons() async {
    final PokemonList pokemonsResponse = await _apiService.getPokemons(offset: page * offset);

    List<PokeInfo> currentPokemonsToShow = pokemonsResponse.results;

    List<Pokemon> pokemonsFullInfo =
        await Future.wait(currentPokemonsToShow.map((p) => _apiService.getPokemon(p.name)));

    List<Specie> eachSpecie = await Future.wait(pokemonsFullInfo.map((pFI) => _apiService.getPokemonSpecie(pFI.id)));

    for (var i = 0; i < pokemonsFullInfo.length; i++) {
      final specie = eachSpecie[i];
      final fullPokemon = pokemonsFullInfo[i];

      if (specie.color.name == 'white') specie.color.name = 'black';
      if (specie.color.name == 'yellow') specie.color.name = 'orange';

      fullPokemon.specie = specie;

      fullPokemon.urlImage = getImageUrl(fullPokemon.id);
    }

    return pokemonsFullInfo;
  }

  String getImageUrl(int id) {
    String auxId = id.toString().addCeros();
    
    String url = 'https://assets.pokemon.com/assets/cms2/img/pokedex/full/';

    url += '$auxId.png';

    return url;
  }
}
