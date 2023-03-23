import 'dart:io';

import 'package:dio/dio.dart';
import 'package:weather_app/data/repository/weather_repository.dart';

class WeatherApiExceptions implements Exception {
  late String message;
  Map<String, dynamic>? data;
  StackTrace? stackTrace;
  RequestOptions? requestOptions;

  WeatherApiExceptions.fromDioError(DioError dioError) {
    stackTrace = dioError.stackTrace;
    requestOptions = dioError.requestOptions;
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = 'Request to API server was cancelled';
        break;
      case DioErrorType.connectionTimeout:
        message = 'Connection timeout with API server - ${dioError.message}';
        break;
      case DioErrorType.receiveTimeout:
        message =
            'Receive timeout in connection with API server - ${dioError.message}';
        break;
      case DioErrorType.badResponse:
        message = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        if (dioError.response?.data is String) {
          data = {'data': message};
          break;
        }
        data = dioError.response?.data;
        break;
      case DioErrorType.sendTimeout:
        message =
            'Send timeout in connection with API server - ${dioError.message}';
        break;
      case DioErrorType.unknown:
        if ((dioError.message ?? 'SocketException')
            .contains('SocketException')) {
          message =
              'There was an error with a socket connection - ${dioError.message}';
          break;
        }
        message = 'Unexpected error occurred: ${dioError.message}';
        break;
      default:
        message = 'Something went wrong: ${dioError.message}';
        break;
    }
  }

  String _handleError(int? statusCode, dataError) {
    String buildErrorString(String statusString) {
      if (dataError is String && dataError.contains('<!DOCTYPE html>')) {
        return statusString;
      }
      if (dataError != null) {
        var errorString = '\n';
        if (dataError['message'] != null) {
          errorString += 'message: ${dataError['message']}\n';
        }
        errorString += 'statusCode: ${statusCode.toString()}\n';
        errorString += 'statusString: $statusString';
        return errorString;
      }
      return dataError.toString();
    }

    switch (statusCode) {
      case HttpStatus.badRequest:
        return buildErrorString('Bad request');
      case HttpStatus.unauthorized:
        return buildErrorString('Unauthorized');
      case HttpStatus.forbidden:
        return buildErrorString('Forbidden');
      case HttpStatus.notFound:
        return buildErrorString('Not Found');
      case HttpStatus.conflict:
        return buildErrorString('Conflict');
      case HttpStatus.internalServerError:
        return buildErrorString('Internal server error');
      case HttpStatus.badGateway:
        return buildErrorString('Bad gateway');
      case HttpStatus.gatewayTimeout:
        return buildErrorString('Gateway timeout');
      default:
        return buildErrorString('Other');
    }
  }

  @override
  String toString() => message;
}

extension PiixApiExceptionsExtend on WeatherApiExceptions {
  ///Gets an error message as a string and parses the
  ///status code of the api response error, if there is no status code
  ///returns -1.
  int get statusCode {
    final errorMessages = toString();
    const statusCodeString = 'statusCode';
    if (errorMessages.contains(statusCodeString)) {
      final codeStartIndex =
          errorMessages.indexOf(statusCodeString) + statusCodeString.length + 2;
      final codeEndIndex = codeStartIndex + 4;
      return int.parse(
          errorMessages.substring(codeStartIndex, codeEndIndex).trim());
    }
    return -1;
  }

  WeatherState get exceptionState {
    final statusCode = this.statusCode;
    var weatherState = WeatherState.idle;
    if (statusCode == HttpStatus.notFound) {
      weatherState = WeatherState.notFound;
    } else if (statusCode == HttpStatus.conflict) {
      weatherState = WeatherState.conflict;
    } else if (statusCode == HttpStatus.badGateway) {
      weatherState = WeatherState.unexpectedError;
    }
    return weatherState;
  }
}
