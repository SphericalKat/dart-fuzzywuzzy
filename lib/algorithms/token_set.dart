import 'dart:math';

import '../applicable.dart';

class TokenSet {
  int apply(String s1, String s2, Applicable ratio) {
    Set<String> tokens1 = s1.split(RegExp("\\s+")).toSet();
    Set<String> tokens2 = s2.split(RegExp("\\s+")).toSet();

    tokens1.length;

    Set<String> intersection = tokens1.intersection(tokens2);
    Set<String> diff1to2 = tokens1.difference(tokens2);
    Set<String> diff2to1 = tokens2.difference(tokens1);

    String sortedInter = (intersection.toList()..sort()).join(" ").trim();
    String sorted1to2 =
        (sortedInter + " " + (diff1to2.toList()..sort()).join(" ")).trim();
    String sorted2to1 =
        (sortedInter + " " + (diff2to1.toList()..sort()).join(" ")).trim();

    List<int> results = [];

    results.add(ratio.apply(sortedInter, sorted1to2));
    results.add(ratio.apply(sortedInter, sorted2to1));
    results.add(ratio.apply(sorted1to2, sorted2to1));

    return results.reduce(max);
  }
}
