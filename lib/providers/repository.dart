import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import 'package:musicavis/repository/boxes.dart';

final instrumentsProvider = Provider<Map<dynamic, String>>((ref) {
  return Hive.box<String>(INSTRUMENTS_BOX).toMap();
});
