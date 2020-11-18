import 'dart:async';

import 'package:flutter/services.dart';

Future<String> loadAsset(String asset) async {
  return await rootBundle.loadString('assets/$asset');
}
