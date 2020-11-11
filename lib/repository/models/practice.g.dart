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
      instrument: fields[0] as String,
      goals: (fields[1] as List)?.cast<String>(),
      exercises: (fields[2] as HiveList)?.castHiveList(),
      positives: (fields[3] as List)?.cast<String>(),
      improvements: (fields[4] as List)?.cast<String>(),
      notes: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Practice obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.instrument)
      ..writeByte(1)
      ..write(obj.goals)
      ..writeByte(2)
      ..write(obj.exercises)
      ..writeByte(3)
      ..write(obj.positives)
      ..writeByte(4)
      ..write(obj.improvements)
      ..writeByte(5)
      ..write(obj.notes);
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
