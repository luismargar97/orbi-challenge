import 'package:flutter/material.dart';
import 'package:orbi_challenge/blog/pokemons.favorite.dart';
import 'package:orbi_challenge/models/pokemon_detail/pokemon.detail.model.dart';
import 'package:orbi_challenge/utils/dictionary.dart';
import 'package:orbi_challenge/widgets/snackbar.widget.dart';
import 'package:pmvvm/pmvvm.dart';

class DetailVM extends ViewModel {
  final FavoritePokemonsService _favoritePokemonsService = FavoritePokemonsService();

  final pageController = PageController(initialPage: 0);

  late Pokemon pokemon;

  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;
  set isFavorite(bool value) {
    _isFavorite = value;
    notifyListeners();
  }

  int _currentPage = 0;
  int get currentPage => _currentPage;
  set currentPage(int value) {
    _currentPage = value;
    notifyListeners();
  }

  bool mounted = false;

  @override
  void onMount() {
    super.onMount();
    mounted = true;
  }

  @override
  void init() {
    super.init();

    pokemon = ModalRoute.of(context)!.settings.arguments as Pokemon;
    _checkIsFavorite();
  }

  void _checkIsFavorite() => isFavorite = _favoritePokemonsService.pokemonsFavoriteIDs.contains(pokemon.id.toString());

  Future<void> handleFavorite() async {
    if (_favoritePokemonsService.pokemonsFavoriteIDs.contains(pokemon.id.toString())) {
      await _removeCharacterFavorite();
    } else {
      await _addCharacterFavorite();
    }

    _checkIsFavorite();
  }

  Future<void> _addCharacterFavorite() async {
    await _favoritePokemonsService.addToFavorite(pokemon);
    if (mounted) StatusSnackbarWidget.showSnackBar(context, type: StatusSnackbar.ok, message: pokemonAdded);
  }

  Future<void> _removeCharacterFavorite() async {
    await _favoritePokemonsService.removeFromFavorite(pokemon);

    if (mounted) StatusSnackbarWidget.showSnackBar(context, type: StatusSnackbar.ok, message: pokemonRemoved);
  }

  void changePage(int page) {
    currentPage = page;

    pageController.jumpToPage(currentPage);
  }
}
