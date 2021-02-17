import 'package:hive/hive.dart';

part 'music_goal.g.dart';

@HiveType(typeId: 3)
class MusicGoal extends HiveObject {
  @HiveField(0)
  String name;

  MusicGoal(this.name);

  void setName(String name) => this.name = name;

  @override
  String toString() => 'MusicGoal { name: $name }';
}
