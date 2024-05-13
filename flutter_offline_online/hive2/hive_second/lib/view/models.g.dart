// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonModelsAdapter extends TypeAdapter<PersonModels> {
  @override
  final int typeId = 1;

  @override
  PersonModels read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PersonModels(
      name: fields[0] as String?,
      age: fields[1] as int?,
      married: fields[2] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, PersonModels obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.age)
      ..writeByte(2)
      ..write(obj.married);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonModelsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
