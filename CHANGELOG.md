## [1.1.7](https://github.com/SphericalKat/dart-fuzzywuzzy/compare/v1.1.6...v1.1.7) (2024-08-15)


### Bug Fixes

* **ratio:** handle NaNs ([5a79f53](https://github.com/SphericalKat/dart-fuzzywuzzy/commit/5a79f535c8562c489434a14fb758ff6eba4cb3f9))

## [1.1.6](https://github.com/SphericalKat/dart-fuzzywuzzy/compare/v1.1.5...v1.1.6) (2023-06-23)


### Bug Fixes

* **changelog:** include older changelog ([0b18b7a](https://github.com/SphericalKat/dart-fuzzywuzzy/commit/0b18b7a2f0201aae5ed5b8e13f25caf1b10dd7bd))

## [1.1.5](https://github.com/SphericalKat/dart-fuzzywuzzy/compare/v1.1.4...v1.1.5) (2023-06-23)


### Bug Fixes

* **ci:** use semantic-release instead of go-semantic-release ([6d84689](https://github.com/SphericalKat/dart-fuzzywuzzy/commit/6d8468965865fb878f8620e20800680bf959c422))
* **treewide:** master -> main ([1f1af68](https://github.com/SphericalKat/dart-fuzzywuzzy/commit/1f1af68baacd0a0d4700afe7354db70272fd4ddd))
* **treewide:** remove unnecessary code ([4bd256b](https://github.com/SphericalKat/dart-fuzzywuzzy/commit/4bd256b23643dd28e6cce81f6fb8e71e3915eb2d))

## 1.1.4 (2023-06-22)

#### Bug Fixes

* **treewide:** fix analyzer issues (47e30949)

## 1.1.3 (2023-06-22)

#### Bug Fixes

* **test:** test against sdk>3.x (f5699e34)

## 1.1.2 (2023-06-22)

#### Bug Fixes

* **ci:** test against a matrix of dart versions (d740510a)

## 1.1.1 (2023-06-22)

#### Bug Fixes

* **ci:** add semrelrc (341bfb9a)

## 1.1.0 (2023-06-22)

#### Feature

* **treewide:** update dependencies (2d2eb08a)

## 1.0.2 (2023-06-18)

#### Bug Fixes

* add support for non ascii characters (fc70dd42)

## 1.0.1 (2022-04-19)

#### Bug Fixes

* **ci:** update changelog file on release (46d77872)

## 1.0.0 (2022-04-19)

#### Feature

* bump version (3928c1c2)
* update dependencies (d1f8fcbf)
* release 0.1.7 (28bc6b53)
* **extraction:** add support for generic list types (f1d0d246)
* **extraction:** add extractors (29e345e4)
* **algorithms:** implement weighted ratio (7aa2c0eb)
* **diffutils:** finish diffutil implementation (d48ad62f)

#### Bug Fixes

* remove outdated test_coverage dependency (fd6fd58f)
* **treewide:** format code using dartfmt (db747832)
* **extractor:** remove debug print statement (0fca8c5e)
* **ratios:** fix splitting on whitespace (f8dc2b6c)

#### Documentation

* **fuzzywuzzy:** add information about getters for generic lists (f8cbb6a2)
* **readme:** update with details about dependencies [skip ci] (e5d7de87)
* **readme:** add extractor examples to readme (d59546b5)
* **changelog:** update for 0.1.2 [skip ci] (dc315e5a)
* **readme:** generate a CI badge [skip ci] (830b4342)
* **readme:** add a readme detailing usage (5f19d9a8)

#### Tests

* add tests for extractors (72e126dc)
* add tests and code coverage (c316f470)

#### Code Refactoring

* use explicit type parameters in tests/example (ffcac28a)
* **diffutils:** remove unnecessary `new` keyword (684bcf18)
* **diffutils:** remove unused code (866186e3)

#### Chores

* **publish:** bump package version (ade8d1c8)
* **build:** bump dependencies (db4cdfdd)
* **publishing:** bump package version (b7101931)
* bump package version [skip ci] (cac8b84a)
* **treewide:** follow pedantic linter rules (e6783f32)
* bump version, add examples and update changelog (36893128)
* **changelog:** create a changelog (6c2feaba)
* **license:** license under gplv2 (e0c4a4ef)
* **fuzzysearch:** dartfmt (00fc4391)

#### CI

* **actions:** add action to generate github releases (83d1eaef)
* add github actions workflow (36231589)

## 0.2.0
- Bump dependencies
- Remove outdated packages
## 0.1.7
- Bump dependencies
- Check if priority queue is empty instead of relying on exceptions

## 0.1.6
- Bump dependencies
- Use explicit type parameters in test and examples

## 0.1.5
- Add support for extraction from generic lists
- Add tests for generic lists
- Update docs with information about generic types

## 0.1.4
- Update readme with more accurate info

## 0.1.3
- Add extractors
- Add tests for extractors
- Improve documentation for ratio algorithms

## 0.1.2
- Add unit tests
- Follow dart file conventions
- Remove unused code
- Remove instances of unnecessary `new` keyword

## 0.1.1
- Add examples
- Fix a bug where string splitting would throw an exception

## 0.1.0
- Initial release
