import '../applicable.dart';
import '../diffutils/diff_utils.dart';

class SimpleRatio implements Applicable {
  @override
  int apply(String s1, String s2) {
    final diff = DiffUtils.getRatio(s1, s2);
    if (diff.isNaN) {
      return 0;
    }
    return (diff * 100).round();
  }
}
