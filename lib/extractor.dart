import 'package:fuzzywuzzy/applicable.dart';
import 'package:fuzzywuzzy/model/extracted_result.dart';
import 'package:collection/collection.dart';

/// Class for extracting matches from a given list
class Extractor {
  final int _cutoff;

  Extractor([this._cutoff = 0]);

  /// Returns the list of choices with their associated scores of similarity in a list of [ExtractedResult]
  List<ExtractedResult> extractWithoutOrder(
      String query, List<String> choices, Applicable func) {
    var yields = List<ExtractedResult>.empty(growable: true);
    var index = 0;

    for (var s in choices) {
      var score = func.apply(query, s);

      if (score >= _cutoff) {
        yields.add(ExtractedResult(s, score, index));
      }
      index++;
    }

    return yields;
  }

  /// Find the single best match above a score in a list of choices
  ExtractedResult extractOne(
      String query, List<String> choices, Applicable func) {
    var extracted = extractWithoutOrder(query, choices, func);

    return extracted.reduce(
        (value, element) => value.score > element.score ? value : element);
  }

  /// Creates a **sorted** list of [ExtractedResult] from the most similar choices
  /// to the least.
  List<ExtractedResult> extractSorted(
      String query, List<String> choices, Applicable func) {
    var best = extractWithoutOrder(query, choices, func)..sort();
    return best.reversed.toList();
  }

  /// Creates a **sorted** list of [ExtractedResult] which contain the top [limit] most similar choices using k-top heap sort
  List<ExtractedResult> extractTop(
      String query, List<String> choices, Applicable func, int limit) {
    var best = extractWithoutOrder(query, choices, func);
    var results = _findTopKHeap(best, limit);
    return results.reversed.toList();
  }

  List<ExtractedResult> _findTopKHeap(List<ExtractedResult> arr, int k) {
    var pq = PriorityQueue<ExtractedResult>();

    for (var x in arr) {
      if (pq.length < k) {
        pq.add(x);
      } else if (x.compareTo(pq.first) > 0) {
        pq.removeFirst();
        pq.add(x);
      }
    }
    var res = List<ExtractedResult>.empty(growable: true);
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
