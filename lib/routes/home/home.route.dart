import 'package:flutter/material.dart';
import 'package:orbi_challenge/routes/home/home.vm.dart';
import 'package:orbi_challenge/utils/colors.dart';
import 'package:orbi_challenge/utils/dictionary.dart';
import 'package:pmvvm/pmvvm.dart';

class HomeNavBarRoute extends StatelessWidget {
  const HomeNavBarRoute({Key? key}) : super(key: key);

  static const route = '/home';

  static late BuildContext context;

  @override
  Widget build(BuildContext context) {
    HomeNavBarRoute.context = context;
    return MVVM<HomeVM>(
      viewModel: HomeVM(),
      view: () => const _HomeScaffold(),
    );
  }
}

class _HomeScaffold extends StatelessView<HomeVM> {
  const _HomeScaffold({
    Key? key,
  }) : super(key: key);

  @override
  Widget render(BuildContext context, HomeVM viewModel) {
    return Scaffold(
      body: viewModel.mainRoutes[viewModel.selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: pokedex),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: favorites),
        ],
        selectedItemColor: viewModel.selectedIndex == 0 ? yellow : red,
        currentIndex: viewModel.selectedIndex,
        onTap: viewModel.changePage,
      ),
    );
  }
}
