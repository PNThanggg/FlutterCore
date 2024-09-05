import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class DioLogger extends Interceptor {
  DioLoggerSettings settings = const DioLoggerSettings();

  DioLogger();

  void configure({
    bool? printResponseData,
    bool? printResponseHeaders,
    bool? printResponseMessage,
    bool? printRequestData,
    bool? printRequestHeaders,
  }) {
    settings = settings.copyWith(
      printRequestData: printRequestData,
      printRequestHeaders: printRequestHeaders,
      printResponseData: printResponseData,
      printResponseHeaders: printResponseHeaders,
      printResponseMessage: printResponseMessage,
    );
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    super.onRequest(options, handler);

    final accepted = settings.requestFilter?.call(options) ?? true;
    if (!accepted) {
      return;
    }

    final message = '${options.uri}';
    final httpLog = DioRequestLog(
      message,
      requestOptions: options,
      settings: settings,
    );

    AppLog("HttpRequest").info(httpLog.generateTextMessage());
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    final accepted = settings.responseFilter?.call(response) ?? true;
    if (!accepted) {
      return;
    }

    final message = '${response.requestOptions.uri}';
    final httpLog = DioResponseLog(
      message,
      settings: settings,
      response: response,
    );

    AppLog("HttpResponse").debug(httpLog.generateTextMessage());
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);

    final message = '${err.requestOptions.uri}';
    final httpErrorLog = DioErrorLog(
      message,
      dioException: err,
      settings: settings,
    );
    AppLog("HttpError").error(httpErrorLog.generateTextMessage());
  }
}
