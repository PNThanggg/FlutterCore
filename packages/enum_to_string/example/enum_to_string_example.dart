import 'package:enum_to_string/enum_to_string.dart';

enum TestEnum { valueOne, valueTwo, valueThree }

void main() {
  // Parse enum to a string
  EnumToString.convertToString(TestEnum.valueOne); //ValueOne
  EnumToString.convertToString(TestEnum.valueTwo); //Value2
  EnumToString.convertToString(TestEnum.valueThree); //valueThree

  // Parse an enum to something more human readable
  EnumToString.convertToString(TestEnum.valueOne); //Value one
  EnumToString.convertToString(TestEnum.valueTwo); //Value 2
  EnumToString.convertToString(TestEnum.valueThree); //Value three

  // Get an enum from a string
  EnumToString.fromString(TestEnum.values, 'ValueOne'); //, TestEnum.ValueOne
  EnumToString.fromString(TestEnum.values, 'Value2'); // TestEnum.Value2
  EnumToString.fromString(TestEnum.values, 'valueThree'); // TestEnum.valueThree

  // Get an enum from a string
  EnumToString.toList<TestEnum>(TestEnum.values);
}
