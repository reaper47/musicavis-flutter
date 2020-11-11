import 'package:hive/hive.dart';

part 'practice.g.dart';

@HiveType(typeId: 2)
class Practice extends HiveObject {
  @HiveField(0)
  String instrument;

  @HiveField(1)
  List<String> goals;

  @HiveField(2)
  HiveList exercises;

  @HiveField(3)
  List<String> positives;

  @HiveField(4)
  List<String> improvements;

  @HiveField(5)
  String notes;

  Practice({
    this.instrument,
    this.goals,
    this.exercises,
    this.positives,
    this.improvements,
    this.notes,
  });
}
