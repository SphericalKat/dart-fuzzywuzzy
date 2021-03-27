import 'algorithms/token_set.dart';
import 'algorithms/token_sort.dart';
import 'algorithms/weighted_ratio.dart';
import 'ratios/partial_ratio.dart';
import 'ratios/simple_ratio.dart';

int ratio(String s1, String s2) {
  return SimpleRatio().apply(s1, s2);
}

int partialRatio(String s1, String s2) {
  return PartialRatio().apply(s1, s2);
}

int tokenSortRatio(String s1, String s2) {
  return TokenSort().apply(s1, s2, SimpleRatio());
}

int tokenSortPartialRatio(String s1, String s2) {
  return TokenSort().apply(s1, s2, PartialRatio());
}

int tokenSetRatio(String s1, String s2) {
  return TokenSet().apply(s1, s2, SimpleRatio());
}

int tokenSetPartialRatio(String s1, String s2) {
  return TokenSet().apply(s1, s2, PartialRatio());
}

/// Calculates a weighted ratio between [s1] and [s2] using the best option from 
/// the above fuzzy matching algorithms
/// 
/// Example:
/// ```dart
/// weightedRatio("The quick brown fox jimps ofver the small lazy dog", "the quick brown fox jumps over the small lazy dog") // 97
/// ```
int weightedRatio(String s1, String s2) {
  return WeightedRatio().apply(s1.toLowerCase(), s2.toLowerCase());
}
