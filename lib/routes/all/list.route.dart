import 'package:flutter/material.dart';
import 'package:orbi_challenge/models/pokemon_list/pokemon.list.model.dart';
import 'package:orbi_challenge/routes/all/list.vm.dart';
import 'package:orbi_challenge/utils/app.sizing.dart';
import 'package:orbi_challenge/utils/dictionary.dart';
import 'package:orbi_challenge/widgets/card.widget.dart';
import 'package:orbi_challenge/widgets/title.widget.dart';
import 'package:pmvvm/pmvvm.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({Key? key}) : super(key: key);

  static const route = '/list';

  @override
  Widget build(BuildContext context) {
    return MVVM<HomeVM>(
      viewModel: HomeVM(),
      view: () => const _View(),
    );
  }
}

class _View extends StatelessView<HomeVM> {
  const _View();

  @override
  Widget render(BuildContext context, HomeVM viewModel) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: Responsive.height,
          padding: EdgeInsets.symmetric(horizontal: Responsive.wp(1.5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _TextFilterButton(),
              PokemonListStream(
                pokemonStream: viewModel.streamPokemons,
                pokemonsFavoriteIDs: viewModel.pokemonsFavoriteIDs,
                scrollController: viewModel.scrollController,
                onCardTap: viewModel.goToDetails,
                handleFavorite: viewModel.handleFavorite,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TextFilterButton extends StatelessView<HomeVM> {
  const _TextFilterButton();

  @override
  Widget render(BuildContext context, HomeVM viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const TitleList(pokedex),
        IconButton(
          onPressed: () => showModalToSort(context, viewModel),
          icon: const Icon(Icons.filter_list_rounded),
        ),
      ],
    );
  }

  Future<void> showModalToSort(BuildContext context, HomeVM viewModel) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(sortBy),
          content: SingleChildScrollView(
            child: ListBody(
              children: SortBy.values
                  .map(
                    (s) => RadioListTile<SortBy>(
                      title: Text(s.translation),
                      value: s,
                      groupValue: viewModel.sortBy,
                      onChanged: viewModel.changeViewBySort,
                    ),
                  )
                  .toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text(cancel),
            ),
          ],
        );
      },
    );
  }
}
