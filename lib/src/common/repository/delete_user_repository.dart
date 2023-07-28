import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';

abstract class DeleteUserRepository {
  Future<String?> delete(String userId);
}

final class DeleteUserRepositoryImpl implements DeleteUserRepository {
  @override
  Future<String?> delete(String userId) async {
    final DatabaseReference reference =
        FirebaseDatabase.instance.ref("users").child(userId);
    try {
      await reference.remove();
      return null;
    } on PlatformException catch (error) {
      return error.message;
    }
  }
}
