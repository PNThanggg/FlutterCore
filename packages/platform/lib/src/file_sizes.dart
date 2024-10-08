const int _divider = 1024;

class FileSize {
  static const PrecisionValue _precisionValue = PrecisionValue.two;

  ///  [size] can be passed as number or as string
  ///  the optional parameter [PrecisionValue] specifies the number
  ///  of digits after comma/point (default is [PrecisionValue.Two])
  ///
  /// Example:
  /// ```dart
  ///    FileSize.getSize(1024)
  ///    FileSize.getSize(1024, precisionValue = PrecisionValue.Four)
  ///  ```
  static String getSize(
    dynamic number, {
    PrecisionValue precision = PrecisionValue.two,
  }) {
    int? size = _parseValue(number);

    if (size < _divider) return getBytes(size);
    if (size < _getDividerValue(2)) return getKiloBytes(size);
    if (size < _getDividerValue(3)) return getMegaBytes(size);
    if (size < _getDividerValue(4)) return getGigaBytes(size);
    if (size < _getDividerValue(5)) return getTeraBytes(size);
    if (size < _getDividerValue(6)) return getPetaBytes(size);
    if (size < _getDividerValue(7)) return getExaBytes(size);
    if (size < _getDividerValue(8)) return getYottaBytes(size);
    if (size < _getDividerValue(9)) return getZettaBytes(size);
    return getZettaBytes(size);
  }

  /// It returns the size of the file in bytes
  ///
  /// [FileSizeType.Bytes]
  static String getBytes(dynamic data) => "${_parseValue(data)} B";

  /// It returns the size of the file in kilo bytes
  ///
  /// [FileSizeType.KiloBytes]
  static String getKiloBytes(dynamic data, {PrecisionValue? value}) {
    return "${(_parseValue(data) / 1024).toStringAsFixed(_getPrecisionValue(value ?? _precisionValue))} KB";
  }

  /// It returns the size of the file in mega bytes
  ///
  /// [FileSizeType.MegaBytes]
  static String getMegaBytes(dynamic data, {PrecisionValue? value}) {
    return "${(_parseValue(data) / _getDividerValue(2)).toStringAsFixed(_getPrecisionValue(value ?? _precisionValue))} MB";
  }

  /// It returns the size of the file in giga bytes
  ///
  /// [FileSizeType.GigaBytes]
  static String getGigaBytes(dynamic data, {PrecisionValue? value}) {
    return "${(_parseValue(data) / _getDividerValue(3)).toStringAsFixed(_getPrecisionValue(value ?? _precisionValue))} GB";
  }

  /// It returns the size of the file in tera bytes
  ///
  /// [FileSizeType.TeraBytes]
  static String getTeraBytes(dynamic data, {PrecisionValue? value}) {
    num r = _parseValue(data) / _getDividerValue(4);
    return "${r.toStringAsFixed(_getPrecisionValue(value ?? _precisionValue))} TB";
  }

  /// It returns the size of the file in peta bytes
  ///
  /// [FileSizeType.PetaBytes]
  static String getPetaBytes(dynamic data, {PrecisionValue? value}) {
    num r = _parseValue(data) / _getDividerValue(5);
    return "${r.toStringAsFixed(_getPrecisionValue(value ?? _precisionValue))} PB";
  }

  /// It returns the size of the file in exa bytes
  ///
  /// [FileSizeType.ExaBytes]
  static String getExaBytes(dynamic data, {PrecisionValue? value}) {
    num r = _parseValue(data) / _getDividerValue(6);
    return "${r.toStringAsFixed(_getPrecisionValue(value ?? _precisionValue))} EB";
  }

  /// It returns the size of the file in yotta bytes
  ///
  /// [FileSizeType.YottaBytes]
  static String getYottaBytes(dynamic data, {PrecisionValue? value}) {
    num r = _parseValue(data) / _getDividerValue(7);
    return "${r.toStringAsFixed(_getPrecisionValue(value ?? _precisionValue))} YB";
  }

  /// It returns the size of the file in zetta bytes
  ///
  /// [FileSizeType.ZettaBytes]
  static String getZettaBytes(dynamic data, {PrecisionValue? value}) {
    num r = _parseValue(data) / _getDividerValue(8);
    return "${r.toStringAsFixed(_getPrecisionValue(value ?? _precisionValue))} ZB";
  }

  static int _parseValue(dynamic size) {
    try {
      return size is int ? size : int.parse(size.toString());
    } on FormatException catch (e) {
      throw FormatException("Can not parse the size parameter: ${e.message}");
    }
  }
}

int _getDividerValue(int numberOf) {
  int finalValue = _divider;
  for (int i = 0; i < numberOf - 1; i++) {
    finalValue *= _divider;
  }
  return finalValue;
}

int _getPrecisionValue(PrecisionValue value) => PrecisionValue.values.indexOf(value);

/// It is for getting the result in the desired string representation
/// By default, it is set to [FileSizeType.Default]
enum FileSizeType { auto, bytes, kiloBytes, megaBytes, gigaBytes, teraBytes, petaBytes, exaBytes, zettaBytes, yottaBytes }

enum PrecisionValue { none, one, two, three, four, five, six, seven }
