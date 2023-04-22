import 'dart:async';

import 'package:flutter/material.dart';
import 'package:orbi_challenge/blog/pokemons.favorite.dart';
import 'package:orbi_challenge/models/pokemon_detail/pokemon.detail.model.dart';
import 'package:orbi_challenge/models/pokemon_list/pokemon.list.model.dart';
import 'package:orbi_challenge/routes/detail/detail.route.dart';
import 'package:orbi_challenge/utils/dictionary.dart';
import 'package:orbi_challenge/utils/sorting.pokemons.dart';
import 'package:orbi_challenge/widgets/snackbar.widget.dart';
import 'package:pmvvm/pmvvm.dart';

class FavoritesVM extends ViewModel {
  final FavoritePokemonsService _favoritePokemonsService = FavoritePokemonsService();

  final StreamController<List<Pokemon>> _streamController = StreamController<List<Pokemon>>();
  Stream<List<Pokemon>> get streamPokemons => _streamController.stream;

  List<Pokemon> favoritePokemonsSaved = [];

  List<String> get pokemonsFavoriteIDs => _favoritePokemonsService.pokemonsFavoriteIDs;
  set pokemonsFavoriteIDs(List<String> v) {
    _favoritePokemonsService.pokemonsFavoriteIDs = v;
    notifyListeners();
  }

  bool mounted = false;

  SortBy _sortBy = SortBy.none;
  SortBy get sortBy => _sortBy;
  set sortBy(SortBy value) {
    SortingPokemon.currentSortMethod = value;
    _sortBy = value;
    notifyListeners();
  }

  @override
  void init() {
    super.init();

    _getFavorites();

    if (sortBy != SortingPokemon.currentSortMethod) sortBy = SortingPokemon.currentSortMethod;

    _sort(sortBy);
  }

  @override
  void onMount() {
    super.onMount();
    mounted = true;
  }

  Future<void> handleFavorite(Pokemon pokemon) async {
    if (_favoritePokemonsService.pokemonsFavoriteIDs.contains(pokemon.id.toString())) {
      await _removeCharacterFavorite(pokemon);
    } else {
      await _addCharacterFavorite(pokemon);
    }

    _getFavorites();
  }

  Future<void> _addCharacterFavorite(Pokemon pokemon) async {
    await _favoritePokemonsService.addToFavorite(pokemon);

    if (mounted) StatusSnackbarWidget.showSnackBar(context, type: StatusSnackbar.ok, message: pokemonAdded);
  }

  Future<void> _removeCharacterFavorite(Pokemon pokemon) async {
    await _favoritePokemonsService.removeFromFavorite(pokemon);

    if (mounted) StatusSnackbarWidget.showSnackBar(context, type: StatusSnackbar.ok, message: pokemonRemoved);
  }

  Future<void> _getFavorites() async {
    favoritePokemonsSaved.clear();

    favoritePokemonsSaved = await _favoritePokemonsService.getFavorites();

    _streamController.add(favoritePokemonsSaved);

    _favoritePokemonsService.pokemonsFavoriteIDs = favoritePokemonsSaved.map((e) => e.id.toString()).toList();

    _sort(sortBy);

    notifyListeners();
  }

  void goToDetails(Pokemon pokemon) =>
      Navigator.pushNamed(context, DetailRoute.route, arguments: pokemon).then((_) => _getFavorites());

  void changeViewBySort(SortBy? newSortBy) {
    Navigator.of(context).pop();

    _sort(newSortBy);
  }

  void _sort(SortBy? newSortBy) {
    sortBy = newSortBy!;

    _streamController.add(SortingPokemon.sortList(favoritePokemonsSaved));
  }
}
