import '../applicable.dart';
import '../diffutils/diff_utils.dart';

class SimpleRatio implements Applicable {
  @override
  int apply(String s1, String s2) {
    return (100 * DiffUtils.getRatio(s1, s2)).round();
  }
}
