import 'package:hive/hive.dart';

part 'exercise.g.dart';

@HiveType(typeId: 1)
class Exercise extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  int bpmStart;

  @HiveField(2)
  int bpmEnd;

  @HiveField(3)
  int minutes;

  Exercise(this.name, this.bpmStart, this.bpmEnd, this.minutes);

  @override
  String toString() =>
      'Exercise { name: $name, bpm: [$bpmStart, $bpmEnd], minutes: $minutes }';
}
