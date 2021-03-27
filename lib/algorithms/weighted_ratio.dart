import 'dart:math';

import '../applicable.dart';
import '../fuzzywuzzy.dart';

class WeightedRatio implements Applicable {
  static const UNBASE_SCALE = 0.95;
  static const PARTIAL_SCALE = 0.90;
  static const TRY_PARTIALS = true;

  @override
  int apply(String s1, String s2) {
    int len1 = s1.length;
    int len2 = s2.length;

    if (len1 == 0 || len2 == 0) {
      return 0;
    }

    bool tryPartials = TRY_PARTIALS;
    double unbaseScale = UNBASE_SCALE;
    double partialScale = PARTIAL_SCALE;

    int base = ratio(s1, s2);
    double lenRatio = max(len1, len2) / min(len1, len2);

    tryPartials = lenRatio >= 1.5;
    if (lenRatio > 8) partialScale = 0.6;

    if (tryPartials) {
      double partial = partialRatio(s1, s2) * partialScale;
      double partialSor =
          tokenSortPartialRatio(s1, s2) * unbaseScale * partialScale;
      double partialSet =
          tokenSetPartialRatio(s1, s2) * unbaseScale * partialScale;

      return [base, partial, partialSor, partialSet].reduce(max).round();
    } else {
      double tokenSort = tokenSortRatio(s1, s2) * unbaseScale;
      double tokenSet = tokenSetRatio(s1, s2) * unbaseScale;

      return [base, tokenSort, tokenSet].reduce(max).round();
    }
  }
}
