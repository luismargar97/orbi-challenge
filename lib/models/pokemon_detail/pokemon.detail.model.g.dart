// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon.detail.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokemonAdapter extends TypeAdapter<Pokemon> {
  @override
  final int typeId = 1;

  @override
  Pokemon read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pokemon(
      abilities: (fields[1] as List).cast<AbilityElement>(),
      id: fields[2] as int,
      stats: (fields[3] as List).cast<Stat>(),
      name: fields[4] as String,
      height: fields[8] as int?,
      weight: fields[7] as int?,
    )
      ..specie = fields[5] as Specie?
      ..urlImage = fields[6] as String?;
  }

  @override
  void write(BinaryWriter writer, Pokemon obj) {
    writer
      ..writeByte(8)
      ..writeByte(1)
      ..write(obj.abilities)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.stats)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.specie)
      ..writeByte(6)
      ..write(obj.urlImage)
      ..writeByte(7)
      ..write(obj.weight)
      ..writeByte(8)
      ..write(obj.height);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AbilityElementAdapter extends TypeAdapter<AbilityElement> {
  @override
  final int typeId = 2;

  @override
  AbilityElement read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AbilityElement(
      ability: fields[1] as StatClass,
      isHidden: fields[2] as bool,
      slot: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, AbilityElement obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.ability)
      ..writeByte(2)
      ..write(obj.isHidden)
      ..writeByte(3)
      ..write(obj.slot);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AbilityElementAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StatClassAdapter extends TypeAdapter<StatClass> {
  @override
  final int typeId = 3;

  @override
  StatClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StatClass(
      name: fields[1] as String,
      url: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, StatClass obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StatAdapter extends TypeAdapter<Stat> {
  @override
  final int typeId = 4;

  @override
  Stat read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Stat(
      baseStat: fields[1] as int,
      effort: fields[2] as int,
      stat: fields[3] as StatClass,
    );
  }

  @override
  void write(BinaryWriter writer, Stat obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.baseStat)
      ..writeByte(2)
      ..write(obj.effort)
      ..writeByte(3)
      ..write(obj.stat);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SpecieAdapter extends TypeAdapter<Specie> {
  @override
  final int typeId = 5;

  @override
  Specie read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Specie(
      color: fields[1] as Color,
      eggGroups: (fields[2] as List).cast<Color>(),
    );
  }

  @override
  void write(BinaryWriter writer, Specie obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.color)
      ..writeByte(2)
      ..write(obj.eggGroups);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpecieAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ColorAdapter extends TypeAdapter<Color> {
  @override
  final int typeId = 6;

  @override
  Color read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Color(
      name: fields[1] as String,
      url: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Color obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ColorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
