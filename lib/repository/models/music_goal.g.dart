// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_goal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MusicGoalAdapter extends TypeAdapter<MusicGoal> {
  @override
  final int typeId = 3;

  @override
  MusicGoal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MusicGoal(
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MusicGoal obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MusicGoalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
