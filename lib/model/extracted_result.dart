/// A model class representing results extracted from a list
class ExtractedResult<T> implements Comparable<ExtractedResult> {
  final T choice;
  final int score;
  final int index;
  final String Function(T obj) _getter;

  /// Creates a new [ExtractedResult] with the given [choice], [score] and [index]
  ExtractedResult(this.choice, this.score, this.index, this._getter);

  @override
  int compareTo(ExtractedResult other) {
    return score.compareTo(other.score);
  }

  @override
  String toString() {
    return '(string ${_getter(choice)}, score: $score, index: $index)';
  }
}
