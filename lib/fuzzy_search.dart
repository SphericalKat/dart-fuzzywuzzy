import 'algorithms/token_set.dart';
import 'algorithms/token_sort.dart';
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
