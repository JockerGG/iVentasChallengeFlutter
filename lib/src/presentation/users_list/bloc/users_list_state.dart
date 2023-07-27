import 'package:iventas_challenge/src/common/models/iv_user.dart';

abstract class UsersListState {
  final List<IVUser> users;

  const UsersListState(this.users);

  factory UsersListState.fetchedData({required List<IVUser> users}) =>
      FetchUsersListState(users: users);
}

final class FetchUsersListState extends UsersListState {
  FetchUsersListState({required List<IVUser> users}) : super(users);
}
