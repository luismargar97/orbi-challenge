import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:orbi_challenge/blog/pokemons.favorite.dart';
import 'package:orbi_challenge/blog/pokemons.list.dart';
import 'package:orbi_challenge/models/pokemon_detail/pokemon.detail.model.dart';
import 'package:orbi_challenge/models/pokemon_list/pokemon.list.model.dart';
import 'package:orbi_challenge/routes/detail/detail.route.dart';
import 'package:orbi_challenge/utils/dictionary.dart';
import 'package:orbi_challenge/utils/sorting.pokemons.dart';
import 'package:orbi_challenge/widgets/snackbar.widget.dart';
import 'package:pmvvm/pmvvm.dart';

class HomeVM extends ViewModel {
  final PokemonsService _pokemonsService = PokemonsService();
  final FavoritePokemonsService _favoritePokemonsService = FavoritePokemonsService();

  final StreamController<List<Pokemon>> _streamController = StreamController<List<Pokemon>>();
  Stream<List<Pokemon>> get streamPokemons => _streamController.stream;

  List<Pokemon> pokemonsLoad = [];
  List<Pokemon> favoritePokemonsSaved = [];

  ScrollController scrollController = ScrollController();

  bool mounted = false;

  List<String> get pokemonsFavoriteIDs => _favoritePokemonsService.pokemonsFavoriteIDs;
  set pokemonsFavoriteIDs(List<String> v) {
    _favoritePokemonsService.pokemonsFavoriteIDs = v;
    notifyListeners();
  }

  SortBy _sortBy = SortBy.none;
  SortBy get sortBy => _sortBy;
  set sortBy(SortBy value) {
    SortingPokemon.currentSortMethod = value;
    _sortBy = value;
    notifyListeners();
  }

  @override
  void onMount() {
    super.onMount();

    mounted = true;
  }

  @override
  void init() {
    super.init();

    scrollController.addListener(scrollListener);

    if (_pokemonsService.pokemonsLoaded.isEmpty) {
      _getPokemons();
    } else {
      pokemonsLoad = _pokemonsService.pokemonsLoaded;
      _addToStream();
    }

    _getFavorites();

    if (sortBy != SortingPokemon.currentSortMethod) sortBy = SortingPokemon.currentSortMethod;

    _sort(sortBy);
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();

    super.dispose();
  }

  void scrollListener() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      _pokemonsService.page += 1;

      _getPokemons();

      log('===>> Adding more items / page: ${_pokemonsService.page}');
    }
  }

  Future<void> handleFavorite(Pokemon pokemon) async {
    if (pokemonsFavoriteIDs.contains(pokemon.id.toString())) {
      await _removeCharacterFavorite(pokemon);
    } else {
      await _addFavorite(pokemon);
    }

    _getFavorites();
  }

  Future<void> _addFavorite(Pokemon pokemon) async {
    await _favoritePokemonsService.addToFavorite(pokemon);

    if (mounted) StatusSnackbarWidget.showSnackBar(context, type: StatusSnackbar.ok, message: pokemonAdded);
  }

  Future<void> _removeCharacterFavorite(Pokemon pokemon) async {
    await _favoritePokemonsService.removeFromFavorite(pokemon);

    if (mounted) StatusSnackbarWidget.showSnackBar(context, type: StatusSnackbar.ok, message: pokemonRemoved);
  }

  Future<void> _getFavorites() async {
    favoritePokemonsSaved = await _favoritePokemonsService.getFavorites();

    pokemonsFavoriteIDs = favoritePokemonsSaved.map((e) => e.id.toString()).toList();

    notifyListeners();
  }

  void _addToStream() => _streamController.add(pokemonsLoad);

  Future<void> _getPokemons() async {
    pokemonsLoad.addAll(await _pokemonsService.getPokemons());

    _pokemonsService.pokemonsLoaded = pokemonsLoad;

    _addToStream();

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

    _streamController.add(SortingPokemon.sortList(pokemonsLoad));
  }
}
