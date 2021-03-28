import 'package:fuzzywuzzy/applicable.dart';
import 'package:fuzzywuzzy/extractor.dart';
import 'package:fuzzywuzzy/model/extracted_result.dart';

import 'algorithms/token_set.dart';
import 'algorithms/token_sort.dart';
import 'algorithms/weighted_ratio.dart';
import 'ratios/partial_ratio.dart';
import 'ratios/simple_ratio.dart';

/// Calculates a Levenshtein simple ratio between the strings
/// This indicates a measure of similarity
int ratio(String s1, String s2) {
  return SimpleRatio().apply(s1, s2);
}

/// Inconsistent substrings lead to problems in matching.
/// This ratio uses a heuristic called "best partial" for when two strings are
/// of noticeably different lengths
int partialRatio(String s1, String s2) {
  return PartialRatio().apply(s1, s2);
}

/// Find all alphanumeric tokens in the string and sort these tokens
/// and then take ratio of resulting joined strings.
int tokenSortRatio(String s1, String s2) {
  return TokenSort().apply(s1, s2, SimpleRatio());
}

/// Find all alphanumeric tokens in the string and sort these tokens
/// and then take partial ratio of resulting joined strings.
int tokenSortPartialRatio(String s1, String s2) {
  return TokenSort().apply(s1, s2, PartialRatio());
}

/// Splits the strings into tokens and computes intersections and remainders
/// between the tokens of the two strings. A comparison string is then
/// built up and is compared using the simple ratio algorithm.
/// Useful for strings where words appear redundantly
int tokenSetRatio(String s1, String s2) {
  return TokenSet().apply(s1, s2, SimpleRatio());
}

/// Splits the strings into tokens and computes intersections and remainders
/// between the tokens of the two strings. A comparison string is then
/// built up and is compared using the partial ratio algorithm.
/// Useful for strings where words appear redundantly
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

/// Returns a sorted list of [ExtractedResult] which contains the top [limit]
/// most similar choices. Will reject any items with scores below the [cutoff].
/// Default [cutoff] is 0
/// Uses [WeightedRatio] as the default algorithm.
List<ExtractedResult> extractTop(
    {required String query,
    required List<String> choices,
    required int limit,
    int cutoff = 0,
    Applicable ratio = const WeightedRatio()}) {
  var extractor = Extractor(cutoff);
  return extractor.extractTop(query, choices, ratio, limit);
}

/// Creates a list of [ExtractedResult] which contains all the choices with
/// their corresponding score where higher is more similar.
/// Uses [WeightedRatio] as the default algorithm
List<ExtractedResult> extractAll(
    {required String query,
    required List<String> choices,
    int cutoff = 0,
    Applicable ratio = const WeightedRatio()}) {
  var extractor = Extractor(cutoff);
  return extractor.extractWithoutOrder(query, choices, ratio);
}

/// Returns a sorted list of [ExtractedResult] without any cutoffs.
/// Uses [WeightedRatio] as the default algorithm.
List<ExtractedResult> extractAllSorted(
    {required String query,
    required List<String> choices,
    int cutoff = 0,
    Applicable ratio = const WeightedRatio()}) {
  var extractor = Extractor(cutoff);
  return extractor.extractSorted(query, choices, ratio);
}

/// Find the single best match above the [cutoff] in a list of choices.
ExtractedResult extractOne(
    {required String query,
    required List<String> choices,
    int cutoff = 0,
    Applicable ratio = const WeightedRatio()}) {
  var extractor = Extractor(cutoff);
  return extractor.extractOne(query, choices, ratio);
}
