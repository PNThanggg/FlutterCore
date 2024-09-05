import 'package:logger/logger.dart';

void main() {
  print('Run with either `dart example/main.dart` or `dart --enable-asserts example/main.dart`.');
  demo();
}

void demo() {
  final log = AppLog("LoggerExample");

  log.debug('Log message with 2 methods');
  log.info('Info message');
  log.warning('Just a warning!');
  log.error(
    'Error! Something bad happened',
    tag: 'Test Error',
  );
}
