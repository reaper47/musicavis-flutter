class Values {
  int min;
  int current;
  int max;

  Values(this.min, this.current, this.max);

  Values.from(Values values) {
    min = values.min;
    current = values.current;
    max = values.max;
  }

  set currentValue(int value) => current = value;
}
