import 'package:flutter/foundation.dart';

const String kToken = 'token';
const String kAppDataName = 'appData';
const String kDecodedDataName = 'decoded';


printOnlyInDebug(dynamic message) {
  if (kDebugMode) {
    print(message);
  }
}
