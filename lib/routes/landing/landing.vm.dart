import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:orbi_challenge/blog/pokemons.list.dart';
import 'package:orbi_challenge/routes/home/home.route.dart';
import 'package:pmvvm/pmvvm.dart';

class LandingVM extends ViewModel {
  final PokemonsService _pokemonsService = PokemonsService();

  bool mounted = false;

  @override
  void onMount() {
    super.onMount();

    mounted = true;
  }

  @override
  void init() {
    super.init();

    _getPokemons();
  }

  Future<void> _getPokemons() async {
    FlutterNativeSplash.remove();

    _pokemonsService.pokemonsLoaded = await _pokemonsService.getPokemons();

    if (mounted) Navigator.pushReplacementNamed(context, HomeNavBarRoute.route);

    notifyListeners();
  }
}
