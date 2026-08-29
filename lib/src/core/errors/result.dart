sealed class Result<T> {
  const Result();

  bool get isSuccess => this is Success<T>;
}

final class Success<T> extends Result<T> {
  const Success(this.value);

  final T value;
}

final class FailureResult<T> extends Result<T> {
  const FailureResult(this.failure);

  final AppFailure failure;
}

sealed class AppFailure {
  const AppFailure();
}

final class NetworkFailure extends AppFailure {
  const NetworkFailure();
}

final class UnauthorizedFailure extends AppFailure {
  const UnauthorizedFailure();
}

final class ForbiddenFailure extends AppFailure {
  const ForbiddenFailure();
}

final class ValidationFailure extends AppFailure {
  const ValidationFailure(this.message);

  final String? message;
}

final class NotFoundFailure extends AppFailure {
  const NotFoundFailure();
}

final class ServerFailure extends AppFailure {
  const ServerFailure();
}

final class UnknownFailure extends AppFailure {
  const UnknownFailure();
}
