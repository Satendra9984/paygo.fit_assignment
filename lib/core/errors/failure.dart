import 'package:equatable/equatable.dart';
import 'package:paygo_fit/core/errors/exceptions.dart';

abstract class Failure extends Equatable {
  Failure({
    required this.message,
    required this.statusCode,
  }) : assert(
          statusCode is String || statusCode is int,
          'StatusCode cannot be a ${statusCode.runtimeType}',
        );

  final String message;
  final dynamic statusCode; //

  @override
  List<Object?> get props => [message, statusCode];

  String get errorMessage => '$statusCode Error: $message';
}



class ServerFailure extends Failure {
  ServerFailure({
    required super.message,
    required super.statusCode,
  });

  ServerFailure.fromException(
    ServerException exception,
  ) : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}


class LocationFailure extends Failure {
  LocationFailure({
    required super.message,
    required super.statusCode,
  });

  LocationFailure.fromException(
    ServerException exception,
  ) : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}