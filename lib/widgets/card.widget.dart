import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:orbi_challenge/models/pokemon_detail/pokemon.detail.model.dart';
import 'package:orbi_challenge/utils/app.sizing.dart';
import 'package:orbi_challenge/utils/colors.dart';
import 'package:orbi_challenge/utils/dictionary.dart';
import 'package:orbi_challenge/utils/extensions.dart';
import 'package:tinycolor2/tinycolor2.dart';

typedef PokemonCallback = void Function(Pokemon);

class PokemonListStream extends StatelessWidget {
  final Stream<List<Pokemon>> pokemonStream;
  final ScrollController? scrollController;
  final List<String> pokemonsFavoriteIDs;
  final PokemonCallback onCardTap;
  final PokemonCallback handleFavorite;

  const PokemonListStream({
    super.key,
    required this.pokemonStream,
    required this.pokemonsFavoriteIDs,
    required this.onCardTap,
    required this.handleFavorite,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<List<Pokemon>>(
        stream: pokemonStream,
        builder: (BuildContext context, AsyncSnapshot<List<Pokemon>> snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final pokemons = snapshot.data;

          if (pokemons!.isEmpty) {
            return Center(
              child: Text(
                noItems,
                style: TextStyle(fontSize: Responsive.dp(3)),
                textAlign: TextAlign.center,
              ),
            );
          }

          return GridView.builder(
            controller: scrollController,
            padding: EdgeInsets.symmetric(vertical: Responsive.hp(1)),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 1.2,
              crossAxisSpacing: 14,
            ),
            itemCount: pokemons.length,
            itemBuilder: (context, index) {
              final pokemon = pokemons[index];

              return _PokeCard(
                pokemon,
                isFavorite: pokemonsFavoriteIDs.contains(pokemon.id.toString()),
                onHeartTap: () => handleFavorite(pokemon),
                onCardTap: () => onCardTap(pokemon),
              );
            },
          );
        },
      ),
    );
  }
}

class _PokeCard extends StatelessWidget {
  final Pokemon pokemon;
  final VoidCallback onCardTap;
  final VoidCallback onHeartTap;
  final bool isFavorite;

  const _PokeCard(this.pokemon, {required this.onHeartTap, required this.isFavorite, required this.onCardTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardTap,
      child: Container(
        margin: EdgeInsets.all(Responsive.dp(1)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Responsive.dp(0.8)),
        ),
        child: Stack(
          children: [
            _CardInfo(pokemon),
            _HeartButton(isFavorite: isFavorite, onHeartTap: onHeartTap),
          ],
        ),
      ),
    );
  }
}

class _CardInfo extends StatelessWidget {
  final Pokemon pokemon;

  const _CardInfo(this.pokemon);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Responsive.dp(1)),
      decoration: BoxDecoration(
        color: TinyColor.fromString(pokemon.specie!.color.name).color,
        borderRadius: BorderRadius.circular(Responsive.dp(0.8)),
        boxShadow: [
          BoxShadow(
            color: grayDynamic.withOpacity(0.2),
            blurRadius: 7,
            offset: const Offset(1, 3),
            spreadRadius: 4,
          ),
        ],
      ),
      child: Stack(
        children: [
          _Image(pokemon.urlImage!),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    pokemon.name.firstToUpper(),
                    style: TextStyle(fontSize: Responsive.dp(1.8), fontWeight: FontWeight.bold, color: white),
                  ),
                  ...pokemon.specie!.eggGroups.map((e) => ChipText(e.name)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Image extends StatelessWidget {
  final String urlImage;

  const _Image(this.urlImage);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: Responsive.hp(2.5),
      right: 0,
      child: CachedNetworkImage(
        imageUrl: urlImage,
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
        height: Responsive.dp(8),
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

class ChipText extends StatelessWidget {
  final String label;

  const ChipText(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Responsive.wp(3), vertical: Responsive.hp(1)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Responsive.dp(50)),
        color: white.withOpacity(0.2),
      ),
      alignment: Alignment.centerLeft,
      child: Text(label, style: TextStyle(fontSize: Responsive.dp(1.6), color: white)),
    );
  }
}

class _HeartButton extends StatefulWidget {
  final VoidCallback onHeartTap;
  final bool isFavorite;

  const _HeartButton({required this.onHeartTap, required this.isFavorite});

  @override
  State<_HeartButton> createState() => _HeartButtonState();
}

class _HeartButtonState extends State<_HeartButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animationScale;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _animationScale = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceOut,
      ),
    );

    _controller.addListener(() {});

    _controller.addStatusListener((status) {});

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.only(
          right: Responsive.dp(0.4),
          bottom: Responsive.dp(0.4),
        ),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return GestureDetector(
              onTap: () async {
                _controller.forward();

                await Future.delayed(const Duration(milliseconds: 101));

                _controller.reverse();

                widget.onHeartTap();
              },
              child: Transform.scale(
                scale: _animationScale.value,
                child: CircleAvatar(
                  maxRadius: Responsive.dp(2),
                  backgroundColor: red,
                  child: Icon(
                    widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                    size: Responsive.dp(3),
                    color: white,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
