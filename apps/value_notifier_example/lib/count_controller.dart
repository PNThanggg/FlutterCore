import 'package:flutter/foundation.dart';

class CountController extends ValueNotifier<int> {
  CountController(super.value);

  int get cnt => value;

  void incrementCount() {
    value += 1;
  }

  void reduceCount() {
    value -= 1;
  }
}
