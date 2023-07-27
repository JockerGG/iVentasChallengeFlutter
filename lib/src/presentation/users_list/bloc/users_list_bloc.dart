import 'package:flutter/material.dart';
import 'package:iventas_challenge/src/common/bloc/bloc.dart';
import 'package:iventas_challenge/src/common/models/field.dart';
import 'package:iventas_challenge/src/common/models/iv_user.dart';
import 'package:iventas_challenge/src/common/models/label.dart';
import 'package:iventas_challenge/src/common/repository/get_users_repository.dart';
import 'package:iventas_challenge/src/presentation/users_list/bloc/users_list_state.dart';

final class UsersListBloc extends Bloc<UsersListState> {
  final GetUsersRepository _getUsersRepository;
  UsersListBloc(this._getUsersRepository) {
    changeState(UsersListState.fetchedData(users: []));
  }

  void retrieve() {
    _getUsersRepository.load(
      (users) {
        changeState(UsersListState.fetchedData(users: users));
      },
    );
  }
}
