# FuzzyWuzzy

This is a dart port of the popular [FuzzyWuzzy](https://github.com/seatgeek/fuzzywuzzy) python package. This algorithm uses [Levenshtein distance](https://en.wikipedia.org/wiki/Levenshtein_distance) to calculate similarity between strings.

I personally needed to use this for my own search algorithms, and there weren't any packages as good as my experience with FuzzyWuzzy was, so here we are. Enjoy!

- No dependencies.
- Pure Dart implementation of the superfast [python-Levenshtein](https://github.com/ztane/python-Levenshtein/).
- Simple to use.
- Lightweight.
- Massive props to the folks over at seatgeek for coming up with the [algorithm](http://chairnerd.seatgeek.com/fuzzywuzzy-fuzzy-string-matching-in-python/).

## Get started

### Add dependency

```yaml
dependencies:
    fuzzywuzzy: 0.1.0 # latest version
```


## Usage
First, import the package
```dart
import 'package:fuzzywuzzy/fuzzywuzzy.dart'
```


### Simple ratio
```dart
ratio("mysmilarstring", "myawfullysimilarstirng") // 72
ratio("mysmilarstring", "mysimilarstring")        // 97
```

### Partial ratio
```dart
partialRatio("similar", "somewhresimlrbetweenthisstring") // 71
```

### Token sort ratio
```dart
tokenSortPartialRatio("order words out of", "words out of order") // 100
tokenSortRatio("order words out of","  words out of order")       // 100
```

### Token set ratio
```dart
tokenSetRatio("fuzzy was a bear", "fuzzy fuzzy fuzzy bear")         // 100
tokenSetPartialRatio("fuzzy was a bear", "fuzzy fuzzy fuzzy bear")  // 100
```

### Weighted ratio
```dart
weightedRatio("The quick brown fox jimps ofver the small lazy dog", "the quick brown fox jumps over the small lazy dog") // 97
```