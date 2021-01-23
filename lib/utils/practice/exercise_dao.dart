import 'package:musicavis/repository/models/exercise.dart';

class ExerciseDao {
  String name;
  int bpmStart;
  int bpmEnd;
  int minutes;

  ExerciseDao(this.name, this.bpmStart, this.bpmEnd, this.minutes);

  ExerciseDao.from(Exercise exercise) {
    name = exercise.name;
    bpmStart = exercise.bpmStart;
    bpmEnd = exercise.bpmEnd;
    minutes = exercise.minutes;
  }

  Exercise toExercise(ExerciseDao dao) =>
      Exercise(dao.name, dao.bpmStart, dao.bpmEnd, dao.minutes);
}
