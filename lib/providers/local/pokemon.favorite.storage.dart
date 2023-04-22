import 'package:hive_flutter/hive_flutter.dart';
import 'package:orbi_challenge/models/pokemon_detail/pokemon.detail.model.dart';

class FavoritePokemonsStorage {
  FavoritePokemonsStorage._internal();

  static final _singleton = FavoritePokemonsStorage._internal();

  factory FavoritePokemonsStorage() => _singleton;

  Future<Box<Pokemon>> openFavoriteBox() => Hive.openBox<Pokemon>('pokemonsBox');

  Future<void> addFavorite(Pokemon character) async {
    final box = await openFavoriteBox();

    box.add(character);
  }

  Future<void> removeFavorite(Pokemon character) async {
    final box = await openFavoriteBox();

    box.delete(character.key);
  }

  Future<List<Pokemon>> getAllFavorites() async {
    final box = await openFavoriteBox();

    return box.values.toList();
  }
}
