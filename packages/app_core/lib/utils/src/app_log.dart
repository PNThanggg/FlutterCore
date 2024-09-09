import 'package:logger/logger.dart';

class AppLog {
  static final ConsoleLogger _loggerNoStack = ConsoleLogger(
    printer: PrettyPrinter(
      methodCount: 0,
      printTime: true,
      errorMethodCount: 0,
    ),
    output: ConsoleOutput(),
    filter: DevelopmentFilter(),
  );

  final String? tag;

  AppLog(this.tag);

  void debug(
    dynamic message, {
    String? tag,
  }) {
    _loggerNoStack.debug(
      message,
      error: tag ?? this.tag ?? "Debug",
    );
  }

  void info(
    dynamic message, {
    String? tag,
  }) {
    _loggerNoStack.info(
      message,
      error: tag ?? this.tag ?? "Info",
    );
  }

  void warning(
    dynamic message, {
    String? tag,
  }) {
    _loggerNoStack.warning(
      message,
      error: tag ?? this.tag ?? "Warning",
    );
  }

  void error(
    dynamic message, {
    String? tag,
  }) {
    _loggerNoStack.error(
      message,
      error: tag ?? this.tag ?? "Error",
    );
  }
}
