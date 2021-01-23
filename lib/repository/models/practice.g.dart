// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'practice.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PracticeAdapter extends TypeAdapter<Practice> {
  @override
  final int typeId = 2;

  @override
  Practice read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Practice(
      instrument: fields[1] as String,
      goals: (fields[2] as List)?.cast<String>(),
      exercises: (fields[3] as HiveList)?.castHiveList(),
      positives: (fields[4] as List)?.cast<String>(),
      improvements: (fields[5] as List)?.cast<String>(),
      notes: fields[6] as String,
      datetime: fields[7] as DateTime,
    )..id = fields[0] as int;
  }

  @override
  void write(BinaryWriter writer, Practice obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.instrument)
      ..writeByte(2)
      ..write(obj.goals)
      ..writeByte(3)
      ..write(obj.exercises)
      ..writeByte(4)
      ..write(obj.positives)
      ..writeByte(5)
      ..write(obj.improvements)
      ..writeByte(6)
      ..write(obj.notes)
      ..writeByte(7)
      ..write(obj.datetime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PracticeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
