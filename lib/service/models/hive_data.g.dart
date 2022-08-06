// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavAdapter extends TypeAdapter<Fav> {
  @override
  final int typeId = 0;

  @override
  Fav read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Fav(
      isFav: fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Fav obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.isFav);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
