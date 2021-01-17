class CrudOperations {
  final ComponentType type;
  final Function add;
  final Function delete;
  final Function update;

  const CrudOperations(this.type, {this.add, this.delete, this.update});
}

enum ComponentType {
  goals,
  positives,
  improvements,
}
