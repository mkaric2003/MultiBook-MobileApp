import 'package:injectable/injectable.dart';
import 'package:multibook/src/core/errors/api_exception.dart';
import 'package:multibook/src/core/errors/result.dart';

@lazySingleton
class RestRepositoryExecutor {
  Future<Result<T>> execute<T>(Future<T> Function() request) async {
    try {
      return Success(await request());
    } on ApiException catch (error) {
      return FailureResult(mapFailure(error));
    } catch (_) {
      return const FailureResult(UnknownFailure());
    }
  }

  AppFailure mapFailure(ApiException error) {
    switch (error.statusCode) {
      case 400:
      case 422:
        return ValidationFailure(error.message);
      case 401:
        return const UnauthorizedFailure();
      case 403:
        return const ForbiddenFailure();
      case 404:
        return const NotFoundFailure();
      case 408:
        return const NetworkFailure();
      case final status? when status >= 500:
        return const ServerFailure();
      default:
        return const NetworkFailure();
    }
  }
}
