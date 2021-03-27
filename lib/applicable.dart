/// A ratio/algorithm that can be applied
abstract class Applicable {
  /// Returns the score of similarity computed from [s1] and [s2]
  int apply(String s1, String s2);
}
