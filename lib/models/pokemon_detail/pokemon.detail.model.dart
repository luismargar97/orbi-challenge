import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

part 'pokemon.detail.model.g.dart';

Pokemon pokemonFromJson(String str) => Pokemon.fromJson(json.decode(str));

String pokemonToJson(Pokemon data) => json.encode(data.toJson());

@HiveType(typeId: 1)
class Pokemon extends HiveObject {
  Pokemon({
    required this.abilities,
    required this.id,
    required this.stats,
    required this.name,
    required this.height,
    required this.weight,
  });

  @HiveField(1)
  List<AbilityElement> abilities;
  @HiveField(2)
  int id;
  @HiveField(3)
  List<Stat> stats;
  @HiveField(4)
  String name;
  @HiveField(5)
  Specie? specie;
  @HiveField(6)
  String? urlImage;
  @HiveField(7)
  int? weight;
  @HiveField(8)
  int? height;

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
        abilities: List<AbilityElement>.from(json["abilities"].map((x) => AbilityElement.fromJson(x))),
        id: json["id"],
        stats: List<Stat>.from(json["stats"].map((x) => Stat.fromJson(x))),
        name: json["name"],
        weight: json["weight"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "abilities": List<dynamic>.from(abilities.map((x) => x.toJson())),
        "id": id,
        "stats": List<dynamic>.from(stats.map((x) => x.toJson())),
        "name": name,
      };

  String getHeight() {
    double convertedHeight = height! * 10;

    return '$height dm ( $convertedHeight cm )';
  }

  String getWeight() {
    double convertedWeight = weight! / 10;

    return '$weight hg ( $convertedWeight kg )';
  }
}

@HiveType(typeId: 2)
class AbilityElement {
  AbilityElement({
    required this.ability,
    required this.isHidden,
    required this.slot,
  });

  @HiveField(1)
  StatClass ability;

  @HiveField(2)
  bool isHidden;

  @HiveField(3)
  int slot;

  factory AbilityElement.fromJson(Map<String, dynamic> json) => AbilityElement(
        ability: StatClass.fromJson(json["ability"]),
        isHidden: json["is_hidden"],
        slot: json["slot"],
      );

  Map<String, dynamic> toJson() => {
        "ability": ability.toJson(),
        "is_hidden": isHidden,
        "slot": slot,
      };
}

@HiveType(typeId: 3)
class StatClass {
  StatClass({
    required this.name,
    required this.url,
  });

  @HiveField(1)
  String name;

  @HiveField(2)
  String url;

  factory StatClass.fromJson(Map<String, dynamic> json) => StatClass(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

@HiveType(typeId: 4)
class Stat {
  Stat({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  @HiveField(1)
  int baseStat;

  @HiveField(2)
  int effort;

  @HiveField(3)
  StatClass stat;

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
        baseStat: json["base_stat"],
        effort: json["effort"],
        stat: StatClass.fromJson(json["stat"]),
      );

  Map<String, dynamic> toJson() => {
        "base_stat": baseStat,
        "effort": effort,
        "stat": stat.toJson(),
      };
}

@HiveType(typeId: 5)
class Specie {
  Specie({
    required this.color,
    required this.eggGroups,
  });

  @HiveField(1)
  Color color;
  @HiveField(2)
  List<Color> eggGroups;

  factory Specie.fromJson(Map<String, dynamic> json) => Specie(
        color: Color.fromJson(json["color"]),
        eggGroups: List<Color>.from(json["egg_groups"].map((x) => Color.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "color": color.toJson(),
        "egg_groups": List<dynamic>.from(eggGroups.map((x) => x.toJson())),
      };
}

@HiveType(typeId: 6)
class Color {
  Color({
    required this.name,
    required this.url,
  });

  @HiveField(1)
  String name;
  @HiveField(2)
  String url;

  factory Color.fromJson(Map<String, dynamic> json) => Color(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
