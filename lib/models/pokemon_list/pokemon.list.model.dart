import 'dart:convert';

import 'package:orbi_challenge/utils/dictionary.dart';

PokemonList pokemonListFromJson(String str) => PokemonList.fromJson(json.decode(str));

String pokemonListToJson(PokemonList data) => json.encode(data.toJson());

class PokemonList {
  PokemonList({
    required this.count,
    required this.results,
  });

  int count;
  List<PokeInfo> results;

  factory PokemonList.fromJson(Map<String, dynamic> json) => PokemonList(
        count: json["count"],
        results: List<PokeInfo>.from(json["results"].map((x) => PokeInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class PokeInfo {
  PokeInfo({
    required this.name,
    required this.url,
  });

  String name;
  String url;

  factory PokeInfo.fromJson(Map<String, dynamic> json) => PokeInfo(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

enum SortBy {
  none(noneLab),
  nameAsc(nameAscLab),
  nameDesc(nameDescLab),
  idAsc(idAscLab),
  idDesc(idDescLab),
  weightAsc(weightAscLab),
  weightDesc(weightDescLab),
  heightAsc(heightAscLab),
  heightDesc(heightDescLab);

  final String translation;

  const SortBy(this.translation);
}
