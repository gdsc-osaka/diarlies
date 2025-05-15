import 'dart:async';

/// Result type
/// ```dart
///
/// ```
/// See https://zenn.dev/kentt8046/articles/20241007-dart-result
sealed class Result<T, E extends Object> {
  /// 処理をラップして[Result]を返す
  factory Result(
    Result<T, E> Function(EarlyReturnSymbol<E> $) f, {
    required Result<T, E> Function(dynamic error, StackTrace stackTrace) onError,
  }) {
    try {
      return f(const EarlyReturnSymbol._());
    } on _EarlyReturnException catch (e) {
      return e.error.cast();
    } catch (e, s) {
      return onError(e, s);
    }
  }

  /// 非同期処理をラップして[Result]を返す
  static Future<Result<T, E>> async<T, E extends Object>(
    FutureOr<Result<T, E>> Function(EarlyReturnSymbol $) f, {
    required FutureOr<Result<T, E>> Function(
      dynamic error,
      StackTrace stackTrace,
    ) onError,
  }) async {
    try {
      return await f(const EarlyReturnSymbol._());
    } on _EarlyReturnException catch (e) {
      return e.error.cast();
    } catch (e, s) {
      return await onError(e, s);
    }
  }

  bool get isOk;

  bool get isErr;

  /// [Ok]の場合は値を返す
  T? ok();

  /// [Err]の場合はエラーを返す
  E? err();

  /// [Ok]の場合は関数を適用して新しい[Ok]を返す
  Result<U, E> map<U>(U Function(T value) f);

  /// [Ok]の場合は関数を適用して新しい値を返して、[Err]の場合はデフォルト値を返す
  U mapOr<U>(U defaultValue, U Function(T value) f);

  /// [Err]の場合は関数を適用して新しい[Err]を返す
  Result<T, F> mapErr<F extends Object>(F Function(E error) f);

  /// [Ok]の場合は引数の[Result]を返す
  Result<U, E> and<U>(Result<U, E> res);

  /// [Ok]の場合は関数を適用して新しい[Result]を返す
  Result<U, E> andThen<U>(Result<U, E> Function(T value) f);

  /// [Err]の場合は引数のResultを返す
  Result<T, F> or<F extends Object>(Result<T, F> res);

  /// [Err]の場合は関数を適用して新しい[Result]を返す
  Result<T, F> orElse<F extends Object>(Result<T, F> Function(E error) f);

  /// キャストして新しい[Result]を返す
  Result<U, F> cast<U, F extends Object>();

  /// [Ok]の値をキャストして新しい[Result]を返す
  Result<U, E> castOk<U>();

  /// [Err]の値をキャストして新しい[Result]を返す
  Result<T, F> castErr<F extends Object>();

  /// [Ok]の場合は関数を実行して自身を返す
  Result<T, E> inspect(void Function(T value) f);

  /// [Err]の場合は関数を実行して自身を返す
  Result<T, E> inspectErr(void Function(E error) f);

  T operator [](EarlyReturnSymbol<E> $);
}

/// `Ok<void, E>(null)`のシンタックスシュガー
Ok<void, E> ok<E extends Object>() => Ok<void, E>(null);

/// 処理の成功を表すクラス
final class Ok<T, E extends Object> implements Result<T, E> {
  const Ok(this.value);

  final T value;

  @override
  bool get isOk => true;

  @override
  bool get isErr => false;

  @override
  T? ok() => value;

  @override
  E? err() => null;

  @override
  Result<U, E> map<U>(U Function(T value) f) {
    return Ok(f(value));
  }

  @override
  U mapOr<U>(U defaultValue, U Function(T value) f) {
    return f(value);
  }

  @override
  Result<T, F> mapErr<F extends Object>(F Function(E error) f) {
    return cast();
  }

  @override
  Result<U, E> and<U>(Result<U, E> res) {
    return res;
  }

  @override
  Result<U, E> andThen<U>(Result<U, E> Function(T value) f) {
    return f(value);
  }

  @override
  Result<T, F> or<F extends Object>(Result<T, F> res) {
    return cast();
  }

  @override
  Result<T, F> orElse<F extends Object>(Result<T, F> Function(E error) f) {
    return cast();
  }

  @override
  Result<U, F> cast<U, F extends Object>() {
    return Ok(value as U);
  }

  @override
  Result<U, E> castOk<U>() {
    return cast();
  }

  @override
  Result<T, F> castErr<F extends Object>() {
    return cast();
  }

  @override
  Result<T, E> inspect(void Function(T value) f) {
    f(value);
    return this;
  }

  @override
  Result<T, E> inspectErr(void Function(E error) f) {
    return this;
  }

  @override
  T operator [](EarlyReturnSymbol<E> $) {
    return value;
  }

  @override
  bool operator ==(Object other) => (other is Ok) && other.value == value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return 'Ok($value)';
  }

  static Ok<T, Object> infer<T>(T value) {
    return Ok(value);
  }
}

/// 処理の失敗を表すクラス
final class Err<T, E extends Object> implements Result<T, E> {
  const Err(this.error);

  final E error;

  @override
  bool get isOk => false;

  @override
  bool get isErr => true;

  @override
  T? ok() => null;

  @override
  E? err() => error;

  @override
  Result<U, E> map<U>(U Function(T value) f) {
    return cast();
  }

  @override
  U mapOr<U>(U defaultValue, U Function(T value) f) {
    return defaultValue;
  }

  @override
  Result<T, F> mapErr<F extends Object>(F Function(E error) f) {
    return Err(f(error));
  }

  @override
  Result<U, E> and<U>(Result<U, E> res) {
    return cast();
  }

  @override
  Result<U, E> andThen<U>(Result<U, E> Function(T value) f) {
    return cast();
  }

  @override
  Result<T, F> or<F extends Object>(Result<T, F> res) {
    return res;
  }

  @override
  Result<T, F> orElse<F extends Object>(Result<T, F> Function(E error) f) {
    return f(error);
  }

  @override
  Result<U, F> cast<U, F extends Object>() {
    return Err(error as F);
  }

  @override
  Result<U, E> castOk<U>() {
    return cast();
  }

  @override
  Result<T, F> castErr<F extends Object>() {
    return cast();
  }

  @override
  Result<T, E> inspect(void Function(T value) f) {
    return this;
  }

  @override
  Result<T, E> inspectErr(void Function(E error) f) {
    f(error);
    return this;
  }

  @override
  T operator [](EarlyReturnSymbol<E> $) {
    throw _EarlyReturnException(this);
  }

  @override
  bool operator ==(Object other) => (other is Err) && other.error == error;

  @override
  int get hashCode => error.hashCode;

  @override
  String toString() {
    return 'Err($error)';
  }

  static Err<dynamic, E> infer<E extends Object>(E error) {
    return Err(error);
  }
}

typedef FutureResult<T, E extends Object> = Future<Result<T, E>>;

extension ResultToFutureExtension<T, E extends Object> on Result<T, E> {
  FutureResult<T, E> toAsync() => Future.value(this);
}

/// [Future]にラップされた[Result]をそのまま扱うための拡張メソッド
extension FutureResultExtension<T, E extends Object> on FutureResult<T, E> {
  Future<bool> get isOk async => (await this) is Ok;

  Future<bool> get isErr async => (await this) is Err;

  Future<T?> ok() async {
    return (await this).ok();
  }

  Future<E?> err() async {
    return (await this).err();
  }

  FutureResult<U, E> map<U>(FutureOr<U> Function(T value) f) async {
    return switch (await this) {
      Ok(:final value) => Ok(await f(value)),
      Err(:final error) => Err(error),
    };
  }

  Future<U> mapOr<U>(U defaultValue, FutureOr<U> Function(T value) f) async {
    return (await this).mapOr(defaultValue, f);
  }

  FutureResult<T, F> mapErr<F extends Object>(
    FutureOr<F> Function(E error) f,
  ) async {
    return switch (await this) {
      Ok(:final value) => Ok(value),
      Err(:final error) => Err(await f(error)),
    };
  }

  FutureResult<U, E> and<U>(Result<U, E> res) async {
    return (await this).and(res);
  }

  FutureResult<U, E> andThen<U>(
    FutureOr<Result<U, E>> Function(T value) f,
  ) async {
    return switch (await this) {
      Ok(:final value) => await f(value),
      Err(:final error) => Err(error),
    };
  }

  FutureResult<T, F> or<F extends Object>(Result<T, F> res) async {
    return (await this).or(res);
  }

  FutureResult<T, F> orElse<F extends Object>(
    FutureOr<Result<T, F>> Function(E error) f,
  ) async {
    return switch (await this) {
      Ok(:final value) => Ok(value),
      Err(:final error) => await f(error),
    };
  }

  FutureResult<U, F> cast<U, F extends Object>() async {
    return (await this).cast();
  }

  FutureResult<U, E> castOk<U>() => cast();

  FutureResult<T, F> castErr<F extends Object>() => cast();

  FutureResult<T, E> inspect(void Function(T value) f) async {
    return (await this).inspect(f);
  }

  FutureResult<T, E> inspectErr(void Function(E error) f) async {
    return (await this).inspectErr(f);
  }

  Future<T> operator [](EarlyReturnSymbol<E> $) async {
    return (await this)[$];
  }
}

/// Nullableな値を[Result]に変換するための拡張メソッド
extension NullableToResultExtension<T> on T? {
  Result<T, E> okOr<E extends Object>(Result<T, E> error) {
    return switch (this) {
      final value? => Ok(value),
      null => error,
    };
  }

  Result<T, E> okOrElse<E extends Object>({required E Function() orElse}) {
    return switch (this) {
      final value? => Ok(value),
      null => Err(orElse()),
    };
  }
}

final class EarlyReturnSymbol<E extends Object> {
  const EarlyReturnSymbol._();
}

class _EarlyReturnException<E extends Object> implements Exception {
  _EarlyReturnException(this.error);

  final Err<dynamic, E> error;
}
