import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:test/test.dart';

class TestContainer {
  final String innerVal;

  TestContainer(this.innerVal);
}

void main() {
  group('Simple ratio', () {
    test('simple ratio returns appropriate values', () {
      final result = ratio('mysmilarstring', 'myawfullysimilarstirng');
      expect(result, 72);
    });

    test('simple ratio returns appropriate values', () {
      final result = ratio('mysmilarstring', 'mysimilarstring');
      expect(result, 97);
    });
  });

  group('Partial ratio', () {
    test('partial ratio returns appropriate values', () {
      final result = partialRatio('similar', 'somewhresimlrbetweenthisstring');
      expect(result, 71);
    });
  });

  group('Token sort ratio', () {
    test('token sort ratio returns appropriate values', () {
      final result =
          tokenSortPartialRatio('order words out of', 'words out of order');
      expect(result, 100);
    });

    test('token sort partial ratio returns appropriate values', () {
      final result = tokenSortRatio('order words out of', 'words out of order');
      expect(result, 100);
    });
  });

  group('Token set ratio', () {
    test('token set ratio returns appropriate values', () {
      final result =
          tokenSetPartialRatio('order words out of', 'words out of order');
      expect(result, 100);
    });

    test('token set partial ratio returns appropriate values', () {
      final result = tokenSetRatio('order words out of', 'words out of order');
      expect(result, 100);
    });
  });

  group('Weighted ratio', () {
    test('weighted ratio returns appropriate values', () {
      final result = weightedRatio(
          'The quick brown fox jimps ofver the small lazy dog',
          'the quick brown fox jumps over the small lazy dog');
      expect(result, 97);
    });

    test('Weighted ratio with newlines', () {
      final result = weightedRatio('\n \n  ', 'test');
      expect(result, 0);
    });
  });

  group('Extractors', () {
    test('extract top returns appropriate values', () {
      final result = extractTop(
        query: 'goolge',
        choices: [
          'google',
          'bing',
          'facebook',
          'linkedin',
          'twitter',
          'googleplus',
          'bingnews',
          'plexoogl'
        ],
        limit: 4,
        cutoff: 50,
      ).toString();
      expect(result,
          '[(string google, score: 83, index: 0), (string googleplus, score: 75, index: 5)]');
    });

    test('extract top with a non-string collection', () {
      final result = extractTop<TestContainer>(
          query: 'goolge',
          choices: [
            'google',
            'bing',
            'facebook',
            'linkedin',
            'twitter',
            'googleplus',
            'bingnews',
            'plexoogl'
          ].map((e) => TestContainer(e)).toList(),
          limit: 4,
          cutoff: 50,
          getter: (x) => x.innerVal).toString();
      expect(result,
          '[(string google, score: 83, index: 0), (string googleplus, score: 75, index: 5)]');
    });
    test('extract all sorted returns appropriate values', () {
      final result = extractAllSorted(
        query: 'goolge',
        choices: [
          'google',
          'bing',
          'facebook',
          'linkedin',
          'twitter',
          'googleplus',
          'bingnews',
          'plexoogl'
        ],
        cutoff: 10,
      ).toString();
      expect(result,
          '[(string google, score: 83, index: 0), (string googleplus, score: 75, index: 5), (string plexoogl, score: 43, index: 7), (string bingnews, score: 29, index: 6), (string linkedin, score: 29, index: 3), (string facebook, score: 29, index: 2), (string bing, score: 23, index: 1), (string twitter, score: 15, index: 4)]');
    });

    test('extract all sorted returns appropriate values for generic container',
        () {
      final result = extractAllSorted<TestContainer>(
        query: 'goolge',
        choices: [
          'google',
          'bing',
          'facebook',
          'linkedin',
          'twitter',
          'googleplus',
          'bingnews',
          'plexoogl'
        ].map((e) => TestContainer(e)).toList(),
        cutoff: 10,
        getter: (x) => x.innerVal,
      ).toString();
      expect(result,
          '[(string google, score: 83, index: 0), (string googleplus, score: 75, index: 5), (string plexoogl, score: 43, index: 7), (string bingnews, score: 29, index: 6), (string linkedin, score: 29, index: 3), (string facebook, score: 29, index: 2), (string bing, score: 23, index: 1), (string twitter, score: 15, index: 4)]');
    });

    test('extract all returns appropriate values', () {
      final result = extractAll(
        query: 'goolge',
        choices: [
          'google',
          'bing',
          'facebook',
          'linkedin',
          'twitter',
          'googleplus',
          'bingnews',
          'plexoogl'
        ],
        cutoff: 10,
      ).toString();
      expect(result,
          '[(string google, score: 83, index: 0), (string bing, score: 23, index: 1), (string facebook, score: 29, index: 2), (string linkedin, score: 29, index: 3), (string twitter, score: 15, index: 4), (string googleplus, score: 75, index: 5), (string bingnews, score: 29, index: 6), (string plexoogl, score: 43, index: 7)]');
    });

    test('extract all returns appropriate values for generic container', () {
      final result = extractAll<TestContainer>(
        query: 'goolge',
        choices: [
          'google',
          'bing',
          'facebook',
          'linkedin',
          'twitter',
          'googleplus',
          'bingnews',
          'plexoogl'
        ].map((e) => TestContainer(e)).toList(),
        cutoff: 10,
        getter: (x) => x.innerVal,
      ).toString();
      expect(result,
          '[(string google, score: 83, index: 0), (string bing, score: 23, index: 1), (string facebook, score: 29, index: 2), (string linkedin, score: 29, index: 3), (string twitter, score: 15, index: 4), (string googleplus, score: 75, index: 5), (string bingnews, score: 29, index: 6), (string plexoogl, score: 43, index: 7)]');
    });

    test('extract one returns appropriate values', () {
      final result = extractOne(
        query: 'cowboys',
        choices: [
          'Atlanta Falcons',
          'New York Jets',
          'New York Giants',
          'Dallas Cowboys'
        ],
        cutoff: 10,
      ).toString();
      expect(result, '(string Dallas Cowboys, score: 90, index: 3)');
    });

    test('extract one returns appropriate values for generic container', () {
      final result = extractOne<TestContainer>(
          query: 'cowboys',
          choices: [
            'Atlanta Falcons',
            'New York Jets',
            'New York Giants',
            'Dallas Cowboys'
          ].map((e) => TestContainer(e)).toList(),
          cutoff: 10,
          getter: (x) => x.innerVal).toString();
      expect(result, '(string Dallas Cowboys, score: 90, index: 3)');
    });
  });
}
