import 'package:flutter/material.dart';
import 'package:orbi_challenge/routes/all/list.route.dart';
import 'package:orbi_challenge/routes/favorites/favorites.route.dart';
import 'package:pmvvm/pmvvm.dart';

class HomeVM extends ViewModel {
  List<Widget> mainRoutes = const [
    HomeRoute(),
    FavoritesRoute(),
  ];

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  set selectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }

  void changePage(int? i) {
    selectedIndex = i!;
  }
}
