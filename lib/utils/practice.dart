import 'package:musicavis/ui/routes/practice/tabs/index.dart';

class CrudOperations {
  final TabType type;
  final Function add;
  final Function delete;
  final Function update;

  const CrudOperations(this.type, {this.add, this.delete, this.update});
}
