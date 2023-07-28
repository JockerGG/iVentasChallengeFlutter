import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:iventas_challenge/src/common/models/iv_user.dart';

abstract class UpdateUserRepository {
  Future<String?> update(String id, IVUser user);
}

final class UpdateUserRepositoryImpl implements UpdateUserRepository {
  @override
  Future<String?> update(String id, IVUser user) async {
    final DatabaseReference reference =
        FirebaseDatabase.instance.ref("/users").child(id);
    try {
      await reference.update(user.toJson());
      return null;
    } on PlatformException catch (error) {
      return error.message;
    }
  }
}
