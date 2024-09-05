import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:platform/platform.dart';
import 'package:platform/src/platform_file.dart';
import 'package:universal_html/html.dart';

///This is a class named VPlatforms that contains static properties and methods for detecting
/// the current platform the code is running on. It includes methods for returning a boolean
/// value for whether the current platform is web, mobile, Android, iOS, Mac OS,
/// and other operating systems. There are also methods for getting the current platform's name and whether
/// it's a desktop platform, as well as detecting whether the code is running on mobile when using a browser. Additionally, there is a method for converting a file to a multipart HTTP request.
abstract class VPlatforms {
  static bool isWeb = kIsWeb;

  static bool get isMobile => isWeb ? false : io.Platform.isAndroid || io.Platform.isIOS;

  static bool get isAndroid => isWeb ? false : io.Platform.isAndroid;

  static bool get isIOS => isWeb ? false : io.Platform.isIOS;

  static bool get isMacOs => isWeb ? false : io.Platform.isMacOS;

  static bool get isDarwin => isWeb ? false : isMacOs || isIOS;

  static String get currentPlatform {
    return currentOs.name;
  }

  static OperatingSystem get currentOs {
    if (isWeb) {
      return OperatingSystem.web;
    }
    if (isAndroid) {
      return OperatingSystem.android;
    }
    if (isIOS) {
      return OperatingSystem.ios;
    }
    if (isLinux) {
      return OperatingSystem.linux;
    }
    if (isWindows) {
      return OperatingSystem.windows;
    }
    if (isMacOs) {
      return OperatingSystem.macOs;
    }
    return OperatingSystem.fuchsia;
  }

  static OperatingSystem get osInWeb {
    if (!isWeb) {
      return currentOs;
    }
    final userAgent = window.navigator.userAgent.toString().toLowerCase();
    if (_isIosInWeb) {
      return OperatingSystem.ios;
    }
    if (userAgent.contains("android")) {
      return OperatingSystem.android;
    }
    if (userAgent.contains("windows")) {
      return OperatingSystem.windows;
    }
    if (userAgent.contains("macintosh")) {
      return OperatingSystem.macOs;
    }
    return OperatingSystem.linux;
  }

  static bool get isWindows => isWeb ? false : io.Platform.isWindows;

  static bool get isDeskTop => isWindows || isLinux || isMacOs;

  static bool get isLinux => isWeb ? false : io.Platform.isLinux;

  // User-agent: iphone chrome
  // Mozilla/5.0 (----iPhone-----; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Mobile/15E148 Safari/604.1
  // User-agent: mac chrome
  // Mozilla/5.0 ( ----Macintosh----; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36
  // User-agent: android chrome
  // Mozilla/5.0 (Linux; -----Android---- 13; sdk_gphone64_arm64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.0.0 Mobile Safari/537.36
  // User-agent: windows chrome
  // Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36 Edg/109.0.1518.70
  static bool get isWebRunOnMobile {
    if (!isWeb) {
      return false;
    }
    final userAgent = window.navigator.userAgent.toString().toLowerCase();
    return (userAgent.contains("android")) || _isIosInWeb;
  }

  static bool get _isIosInWeb {
    final userAgent = window.navigator.userAgent.toString().toLowerCase();
    return userAgent.contains("iphone") || userAgent.contains("ipad");
  }

  static Future<http.MultipartFile> getMultipartFile({
    required PlatformFile source,
    String fieldName = "file",
  }) async {
    final mimeType = source.mimeType;
    final fileLocalPath = source.fileLocalPath;
    final bytes = source.bytes;

    final contentType = mimeType != null ? MediaType.parse(mimeType) : null;
    final file = bytes != null
        ? http.MultipartFile.fromBytes(
            fieldName,
            bytes,
            filename: source.name,
            contentType: contentType,
          )
        : await http.MultipartFile.fromPath(
            fieldName,
            fileLocalPath!,
            filename: source.name,
            contentType: contentType,
          );

    return file;
  }
}
