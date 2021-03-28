import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:test/test.dart';

void main() {
  group('Simple ratio', () {
    test('simple ratio returns appropriate values', () {
      final result = ratio("mysmilarstring", "myawfullysimilarstirng");
      expect(result, 72);
    });

    test('simple ratio returns appropriate values', () {
      final result = ratio("mysmilarstring", "mysimilarstring");
      expect(result, 97);
    });
  });

  group('Partial ratio', () {
    test('partial ratio returns appropriate values', () {
      final result = partialRatio("similar", "somewhresimlrbetweenthisstring");
      expect(result, 71);
    });
  });

  group('Token sort ratio', () {
    test('token sort ratio returns appropriate values', () {
      final result =
          tokenSortPartialRatio("order words out of", "words out of order");
      expect(result, 100);
    });

    test('token sort partial ratio returns appropriate values', () {
      final result = tokenSortRatio("order words out of", "words out of order");
      expect(result, 100);
    });
  });

  group('Token set ratio', () {
    test('token set ratio returns appropriate values', () {
      final result =
          tokenSetPartialRatio("order words out of", "words out of order");
      expect(result, 100);
    });

    test('token set partial ratio returns appropriate values', () {
      final result = tokenSetRatio("order words out of", "words out of order");
      expect(result, 100);
    });
  });

  group('Weighted ratio', () {
    test('weighted ratio returns appropriate values', () {
      final result = weightedRatio(
          "The quick brown fox jimps ofver the small lazy dog",
          "the quick brown fox jumps over the small lazy dog");
      expect(result, 97);
    });
  });
}
