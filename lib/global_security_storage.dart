import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:moveo_app/model/user_model.dart';


class GlobalSecurityStorage {
  static const storage = FlutterSecureStorage();
  static const userKey = 'user';

  static Future setUser (UserModel user) async {
    final value = jsonEncode(user);
    print(value);
    //print(value.runtimeType);
    await storage.write(key: userKey, value: value);
  }
  /*
  static Future<Map<String, dynamic>?> getUser() async {
    final value = await storage.read(key: userKey);
    return value == null ? null : jsonDecode(value);
  }

  */
  static Future<Map<String, dynamic>?> getUser() async {
    final value = await storage.read(key: userKey);
    return value == null ? null : jsonDecode(value);
  }
  static Future deleteAllStorageData() async {
    await storage.deleteAll();
  }
}