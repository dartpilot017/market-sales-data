Iterable<int> generateNumbers(int max) sync* {
  for (var i = 1; i <= max; i++) {
    yield i;
  }
}
