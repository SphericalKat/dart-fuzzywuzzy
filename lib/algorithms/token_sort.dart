import '../applicable.dart';

class TokenSort {
  int apply(String s1, String s2, Applicable ratio) {
    var sorted1 = sort(s1);
    var sorted2 = sort(s2);

    return ratio.apply(sorted1, sorted2);
  }

  static String sort(String s) {
    var words = s.split(RegExp('\\s+'))..sort();
    var joined = words.join(' ');
    return joined.trim();
  }
}
