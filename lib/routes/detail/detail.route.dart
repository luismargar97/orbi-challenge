import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:orbi_challenge/models/pokemon_detail/pokemon.detail.model.dart';
import 'package:orbi_challenge/routes/detail/detail.vm.dart';
import 'package:orbi_challenge/utils/app.sizing.dart';
import 'package:orbi_challenge/utils/colors.dart';
import 'package:orbi_challenge/utils/dictionary.dart';
import 'package:orbi_challenge/utils/extensions.dart';
import 'package:orbi_challenge/widgets/card.widget.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:tinycolor2/tinycolor2.dart';

part 'widgets/detail.widgets.dart';

class DetailRoute extends StatelessWidget {
  const DetailRoute({Key? key}) : super(key: key);

  static const route = '/detail';

  @override
  Widget build(BuildContext context) {
    return MVVM<DetailVM>(
      viewModel: DetailVM(),
      view: () => Scaffold(
        body: Stack(
          children: const [
            _Background(),
            _Content(),
          ],
        ),
      ),
    );
  }
}

class _Background extends StatelessView<DetailVM> {
  const _Background();

  @override
  Widget render(BuildContext context, DetailVM viewModel) {
    return Stack(
      children: [
        Container(
          height: Responsive.height,
          color: TinyColor.fromString(viewModel.pokemon.specie!.color.name).color,
        ),
        Positioned(
          bottom: 0,
          child: Container(
            height: Responsive.hp(55),
            width: Responsive.width,
            decoration: BoxDecoration(
              color: grayLight,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Responsive.dp(2)),
                topRight: Radius.circular(Responsive.dp(2)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Content extends StatelessView<DetailVM> {
  const _Content();

  @override
  Widget render(BuildContext context, DetailVM viewModel) {
    return Container(
      padding: EdgeInsets.only(
        left: Responsive.wp(2),
        right: Responsive.wp(2),
        top: Responsive.hp(6),
      ),
      child: Wrap(
        runSpacing: Responsive.hp(2),
        children: [
          _ArrowFavButton(isFavorite: viewModel.isFavorite, handleFavorite: viewModel.handleFavorite),
          _Titles(viewModel.pokemon),
          _Image(viewModel.pokemon.urlImage!),
          const _Views(),
        ],
      ),
    );
  }
}

class _ArrowFavButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback handleFavorite;

  const _ArrowFavButton({
    required this.isFavorite,
    required this.handleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: Navigator.of(context).pop,
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Colors.white,
            size: Responsive.dp(3),
          ),
        ),
        IconButton(
          onPressed: handleFavorite,
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: Colors.white,
            size: Responsive.dp(3),
          ),
        ),
      ],
    );
  }
}

class _Titles extends StatelessWidget {
  final Pokemon pokemon;

  const _Titles(this.pokemon);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: Responsive.hp(2),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              pokemon.name.firstToUpper(),
              style: TextStyle(
                fontSize: Responsive.dp(3),
                color: white,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            Text(
              '# ${pokemon.id.toString().addCeros()}',
              style: TextStyle(
                fontSize: Responsive.dp(2.4),
                color: white,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        Row(
            children: pokemon.specie!.eggGroups
                .map((e) => Padding(
                      padding: EdgeInsets.only(right: Responsive.wp(2)),
                      child: ChipText(e.name),
                    ))
                .toList()),
      ],
    );
  }
}

class _Image extends StatelessWidget {
  final String urlImage;

  const _Image(this.urlImage);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Responsive.width,
      child: CachedNetworkImage(
        imageUrl: urlImage,
        height: Responsive.hp(22.5),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        progressIndicatorBuilder: (context, url, downloadProgress) {
          return CircularProgressIndicator(
            value: downloadProgress.progress,
            color: red,
          );
        },
      ),
    );
  }
}

class _Views extends StatelessView<DetailVM> {
  const _Views();

  @override
  Widget render(BuildContext context, DetailVM viewModel) {
    return SizedBox(
      height: Responsive.hp(45),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _TextPagesTitles(
                label: about,
                isShowed: viewModel.currentPage == 0,
                changePage: () => viewModel.changePage(0),
              ),
              _TextPagesTitles(
                label: baseStats,
                isShowed: viewModel.currentPage == 1,
                changePage: () => viewModel.changePage(1),
              ),
              _TextPagesTitles(
                label: evolution,
                isShowed: viewModel.currentPage == 2,
                changePage: () => viewModel.changePage(2),
              ),
              _TextPagesTitles(
                label: moves,
                isShowed: viewModel.currentPage == 3,
                changePage: () => viewModel.changePage(3),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: Responsive.hp(1)),
              child: PageView(
                controller: viewModel.pageController,
                onPageChanged: (value) => viewModel.currentPage = value,
                children: const [
                  _Page1(),
                  _Page(),
                  _Page(),
                  _Page(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
