import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:iventas_challenge/src/common/models/iv_user.dart';

abstract class SetUserRepository {
  Future<String?> set(IVUser user);
}

final class SetUserRepositoryImpl implements SetUserRepository {
  SetUserRepositoryImpl();

  @override
  Future<String?> set(IVUser user) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("users");
    DatabaseReference newUserRef = ref.push();
    if (newUserRef.key != null) {
      user.id = newUserRef.key!;
    }
    try {
      await newUserRef.set(user.toJson());
      return null;
    } on PlatformException catch (error) {
      return error.message;
    }
  }
}
