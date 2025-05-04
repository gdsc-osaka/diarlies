# Format dart files
(cd lib && find lib -type f -name "*.dart" -not -name "*.g.dart" -not -name "*.freezed.dart" -print0 | xargs -0 dart format -o none -l 100)