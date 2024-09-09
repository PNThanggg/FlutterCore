import 'package:logger/logger.dart';

void main() {
  print('Run with either `dart example/main.dart` or `dart --enable-asserts example/main.dart`.');
  demo();
}

void demo() {
  final ConsoleLogger loggerNoStack = ConsoleLogger(
    printer: PrettyPrinter(
      methodCount: 0,
      printTime: true,
      errorMethodCount: 0,
    ),
    output: ConsoleOutput(),
    filter: DevelopmentFilter(),
  );

  loggerNoStack.debug('Log message with 2 methods');
  loggerNoStack.info('Info message');
  loggerNoStack.warning('Just a warning!');
  loggerNoStack.error(
    'Error! Something bad happened',
  );
}
