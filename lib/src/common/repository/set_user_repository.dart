import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:iventas_challenge/src/common/models/iv_user.dart';

abstract class SetUserRepository {
  void add(IVUser user);
}

final class SetUserRepositoryImpl implements SetUserRepository {
  SetUserRepositoryImpl();

  @override
  Future<String?> add(IVUser user) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("users");
    DatabaseReference newUserRef = ref.push();
    try {
      await newUserRef.set(user.toJson());
      return null;
    } on PlatformException catch (error) {
      return error.message;
    }
  }
}
