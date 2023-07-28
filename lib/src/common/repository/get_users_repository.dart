import 'package:firebase_database/firebase_database.dart';
import 'package:iventas_challenge/src/common/models/iv_user.dart';

abstract class GetUsersRepository {
  void load(Function(List<IVUser>) onFetched);
}

final class GetUsersRepositoryImpl implements GetUsersRepository {
  @override
  void load(Function(List<IVUser>) onFetched) {
    FirebaseDatabase.instance.ref('/users').onValue.listen((event) {
      if (event.snapshot.value != null) {
        final Map<dynamic, dynamic> jsonData = (event.snapshot.value as Map);
        final List<IVUser> users = jsonData.entries
            .map((value) =>
                IVUser.fromJson(id: value.key as String, json: value.value))
            .toList();
        onFetched(users);
      }
    });
  }
}
