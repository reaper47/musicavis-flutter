import 'package:musicavis/repository/models/exercise.dart';

class CrudOperations {
  final Function add;
  final Function delete;
  final Function update;

  CrudOperations({this.add, this.delete, this.update});
}

class Exercises {
  final List<Exercise> exercises;
  List<bool> isEnabled;

  Exercises.create(this.exercises) {
    isEnabled = exercises.map((e) => true).toList();
  }

  int get length => exercises.length;

  void toggleEnabled(int index) {
    isEnabled[index] = !isEnabled[index];
  }
}
