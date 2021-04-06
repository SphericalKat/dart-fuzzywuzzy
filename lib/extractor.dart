import 'package:fuzzywuzzy/applicable.dart';
import 'package:fuzzywuzzy/model/extracted_result.dart';
import 'package:collection/collection.dart';

/// Class for extracting matches from a given list
class Extractor {
  final int _cutoff;

  Extractor([this._cutoff = 0]);

  /// Returns the list of choices with their associated scores of similarity in a list of [ExtractedResult]
  List<ExtractedResult<T>> extractWithoutOrder<T>(
      String query, List<T> choices, Applicable func,
      [String Function(T obj)? getter]) {
    var yields = List<ExtractedResult<T>>.empty(growable: true);
    var index = 0;

    if (T != String) {
      if (getter == null) {
        throw ArgumentError('Getter cannot be null for non-string types!');
      }
    } else {
      getter = (obj) => (obj as String);
    }

    for (var s in choices) {
      var score = func.apply(query.toLowerCase(), getter(s).toLowerCase());

      if (score >= _cutoff) {
        yields.add(ExtractedResult<T>(s, score, index, getter));
      }
      index++;
    }

    return yields;
  }

  /// Find the single best match above a score in a list of choices
  ExtractedResult<T> extractOne<T>(
      String query, List<T> choices, Applicable func,
      [String Function(T obj)? getter]) {
    var extracted = extractWithoutOrder(query, choices, func, getter);

    return extracted.reduce(
        (value, element) => value.score > element.score ? value : element);
  }

  /// Creates a **sorted** list of [ExtractedResult] from the most similar choices
  /// to the least.
  List<ExtractedResult<T>> extractSorted<T>(
      String query, List<T> choices, Applicable func,
      [String Function(T obj)? getter]) {
    var best = extractWithoutOrder(query, choices, func, getter)..sort();
    return best.reversed.toList();
  }

  /// Creates a **sorted** list of [ExtractedResult] which contain the top [limit] most similar choices using k-top heap sort
  List<ExtractedResult<T>> extractTop<T>(
      String query, List<T> choices, Applicable func, int limit,
      [String Function(T obj)? getter]) {
    var best = extractWithoutOrder(query, choices, func, getter);
    var results = _findTopKHeap(best, limit);
    return results.reversed.toList();
  }

  List<ExtractedResult<T>> _findTopKHeap<T>(
      List<ExtractedResult<T>> arr, int k) {
    var pq = PriorityQueue<ExtractedResult<T>>();

    for (var x in arr) {
      if (pq.length < k) {
        pq.add(x);
      } else if (x.compareTo(pq.first) > 0) {
        pq.removeFirst();
        pq.add(x);
      }
    }
    var res = List<ExtractedResult<T>>.empty(growable: true);
    for (var i = k; i > 0; i--) {
      try {
        var polled = pq.removeFirst();
        res.add(polled);
      } catch (e) {
        continue;
      }
    }
    return res;
  }
}
