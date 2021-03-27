import '../applicable.dart';
import '../diffutils/diff_utils.dart';
import '../diffutils/structs/matching_block.dart';

import 'dart:math';

class PartialRatio implements Applicable {
  @override
  int apply(String s1, String s2) {
    String shorter;
    String longer;

    if (s1.length < s2.length) {
      shorter = s1;
      longer = s2;
    } else {
      shorter = s2;
      longer = s1;
    }

    List<MatchingBlock> matchingBlocks =
        DiffUtils.getMatchingBlocks(shorter, longer);

    List<double> scores = [];

    for (MatchingBlock mb in matchingBlocks) {
      int dist = mb.dpos! - mb.spos!;

      int longStart = dist > 0 ? dist : 0;
      int longEnd = longStart + shorter.length;

      if (longEnd > longer.length) longEnd = longer.length;

      String longSubstr = longer.substring(longStart, longEnd);

      double ratio = DiffUtils.getRatio(shorter, longSubstr);

      if (ratio > 0.995) {
        return 100;
      } else {
        scores.add(ratio);
      }
    }

    return scores.isEmpty ? 0 : (100 * scores.reduce(max)).round();
  }
}
