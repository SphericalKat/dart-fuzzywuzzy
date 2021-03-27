import '../applicable.dart';

class TokenSort {
  int apply(String s1, String s2, Applicable ratio) {
    String sorted1 = sort(s1);
    String sorted2 = sort(s2);

    return ratio.apply(sorted1, sorted2);
  }

  static String sort(String s) {
    List<String> words = s.split("\\s+")..sort();
    String joined = words.join(" ");
    return joined.trim();
  }
}
