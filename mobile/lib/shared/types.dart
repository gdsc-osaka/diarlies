import 'dart:async';

typedef FutureOrCallback<T> = FutureOr<T> Function();

typedef FutureOrValueChanged<T, P> = FutureOr<T> Function(P value);