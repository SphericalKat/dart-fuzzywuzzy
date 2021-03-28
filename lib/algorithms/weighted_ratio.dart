import 'dart:math';

import '../applicable.dart';
import '../fuzzywuzzy.dart';

class WeightedRatio implements Applicable {
  static const UNBASE_SCALE = 0.95;
  static const PARTIAL_SCALE = 0.90;
  static const TRY_PARTIALS = true;

  const WeightedRatio();

  @override
  int apply(String s1, String s2) {
    var len1 = s1.length;
    var len2 = s2.length;

    if (len1 == 0 || len2 == 0) {
      return 0;
    }

    var tryPartials = TRY_PARTIALS;
    var unbaseScale = UNBASE_SCALE;
    var partialScale = PARTIAL_SCALE;

    var base = ratio(s1, s2);
    var lenRatio = max(len1, len2) / min(len1, len2);

    tryPartials = lenRatio >= 1.5;
    if (lenRatio > 8) partialScale = 0.6;

    if (tryPartials) {
      var partial = partialRatio(s1, s2) * partialScale;
      var partialSor =
          tokenSortPartialRatio(s1, s2) * unbaseScale * partialScale;
      var partialSet =
          tokenSetPartialRatio(s1, s2) * unbaseScale * partialScale;

      return [base, partial, partialSor, partialSet].reduce(max).round();
    } else {
      var tokenSort = tokenSortRatio(s1, s2) * unbaseScale;
      var tokenSet = tokenSetRatio(s1, s2) * unbaseScale;

      return [base, tokenSort, tokenSet].reduce(max).round();
    }
  }
}
