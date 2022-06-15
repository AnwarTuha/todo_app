// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppTokenAdapter extends TypeAdapter<AppToken> {
  @override
  final int typeId = 0;

  @override
  AppToken read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppToken(
      token: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AppToken obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.token);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppTokenAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
