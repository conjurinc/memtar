# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Security

- Updated Dockerfile.test base image to use Ruby 3.0.4

## [0.1.4] - 2020-03-04

### Changed

- Bumped rake version to resolve the following security vulnerability (CVE-2020-8130)

## [0.1.3] - 2019-11-20

### Fixed

- File entries are correctly padded to the 512 byte boundary without introducing
  entire 512 byte blocks of null data.

## [0.1.2] - 2019-09-06

## [0.1.1] - 2019-08-27

## [0.1.0] - 2015-02-23

## [0.0.1] - 2015-02-18

[Unreleased]: https://github.com/conjurinc/memtar/compare/v0.1.4...HEAD
[0.1.4]: https://github.com/conjurinc/memtar/compare/v0.1.3...v0.1.4
[0.1.3]: https://github.com/conjurinc/memtar/compare/v0.1.2...v0.1.3
[0.1.2]: https://github.com/conjurinc/memtar/compare/v0.1.1...v0.1.2
[0.1.1]: https://github.com/conjurinc/memtar/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/conjurinc/memtar/compare/v0.0.1...v0.1.0
[0.0.1]: https://github.com/conjurinc/memtar/compare/v0.0.1
