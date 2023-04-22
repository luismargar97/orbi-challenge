import 'package:orbi_challenge/models/pokemon_detail/pokemon.detail.model.dart';
import 'package:orbi_challenge/providers/local/pokemon.favorite.storage.dart';

class FavoritePokemonsService {
  FavoritePokemonsService._internal();

  static final _singleton = FavoritePokemonsService._internal();

  factory FavoritePokemonsService() => _singleton;

  final FavoritePokemonsStorage _favoriteStorage = FavoritePokemonsStorage();

  List<String> pokemonsFavoriteIDs = [];

  Future<void> addToFavorite(Pokemon pokemon) async {
    pokemonsFavoriteIDs.add(pokemon.id.toString());

    _favoriteStorage.addFavorite(pokemon);
  }

  Future<void> removeFromFavorite(Pokemon pokemon) async {
    pokemonsFavoriteIDs.removeWhere((p) => p == pokemon.id.toString());

    List<Pokemon> availableFav = await getFavorites();

    final itemToRemove = availableFav.firstWhere((a) => a.id == pokemon.id);

    _favoriteStorage.removeFavorite(itemToRemove);
  }

  Future<List<Pokemon>> getFavorites() async => _favoriteStorage.getAllFavorites();
}
