/// A model class representing results extracted from a list
class ExtractedResult implements Comparable<ExtractedResult> {
  final String string;
  final int score;
  final int index;

  /// Creates a new [ExtractedResult] with the given [string], [score] and [index]
  ExtractedResult(this.string, this.score, this.index);

  @override
  int compareTo(ExtractedResult other) {
    return score.compareTo(other.score);
  }

  @override
  String toString() {
    return '(string $string, score: $score, index: $index)';
  }
}
