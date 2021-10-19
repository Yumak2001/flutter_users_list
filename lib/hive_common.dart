import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'config.dart';

late final Box hiveBox;

initHive() async {
  await Hive.initFlutter();
  hiveBox = await Hive.openBox(HiveConf.username);
}

String? getUsername() {
  var username = hiveBox.get(HiveConf.username, defaultValue: '');
  return username;
}

setUsername(String _username) {
  hiveBox.put(HiveConf.username, _username);
}

deleteUsername() {
  hiveBox.delete(HiveConf.username);
}