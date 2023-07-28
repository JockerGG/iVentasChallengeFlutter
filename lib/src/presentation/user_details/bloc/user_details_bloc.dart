import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iventas_challenge/src/common/bloc/bloc.dart';
import 'package:iventas_challenge/src/common/models/field.dart';
import 'package:iventas_challenge/src/common/models/iv_user.dart';
import 'package:iventas_challenge/src/common/models/label.dart';
import 'package:iventas_challenge/src/common/repository/delete_user_repository.dart';
import 'package:iventas_challenge/src/common/repository/set_user_repository.dart';
import 'package:iventas_challenge/src/common/repository/update_user_repository.dart';
import 'package:iventas_challenge/src/presentation/user_details/bloc/user_details_state.dart';
import 'package:iventas_challenge/src/utils/color_extensions.dart';

final class UsersDetailsBloc extends Bloc<UserDetailsState> {
  final SetUserRepository _setUserRepository;
  final UpdateUserRepository _updateUserRepository;
  final DeleteUserRepository _deleteUserRepository;
  final TextEditingController alertTextFieldController =
      TextEditingController();
  final List<Color> labelColors = [
    Colors.red,
    Colors.yellow,
    Colors.blueAccent,
    Colors.blue,
    Colors.green,
    Colors.brown,
    Colors.orange,
    Colors.indigo,
    Colors.purple,
    Colors.pink
  ];
  late IVUser? user;
  late FormType formType;
  Map originalUser = {};
  Map<String, TextEditingController> _controllers = {};
  List<String> _addedControllers = [];
  Map<String, TextEditingController> _deletedControllers = {};
  String _id = "";

  UsersDetailsBloc(this._setUserRepository, this._updateUserRepository,
      this._deleteUserRepository) {
    init(null);
  }

  void init(IVUser? user, {FormType formType = FormType.create}) {
    this.user = user;
    this.formType = formType;
    if (user != null) {
      _id = user.id;
      originalUser = user.toJson();
      Map userJson = user.toJson();
      userJson.remove("labels");
      userJson.remove("otherFields");

      for (var value in userJson.entries) {
        _controllers[value.key] = TextEditingController(text: value.value);
      }

      if (user.otherFields.isNotEmpty) {
        for (var element in user.otherFields) {
          _controllers[element.name] =
              TextEditingController(text: element.value);
        }
      }
    }

    changeState(UserDetailsState.updateUser(user, false, false));
  }

  Future<String?> delete() async {
    if (user != null) {
      final message = await _deleteUserRepository.delete(user!.id);
      return message;
    }

    return "Ocurrió un error inesperado";
  }

  TextEditingController? getController(String key) => _controllers[key];

  void update(String field, String value, {bool mainFields = true}) {
    if (state.user != null) {
      IVUser userUpdated = state.user!;
      Map<String, dynamic> user = state.user!.toJson();
      if (mainFields) {
        user[field] = value;
        userUpdated = IVUser.fromJson(json: user);
      } else {
        final index =
            userUpdated.otherFields.indexWhere((f) => f.name == field);
        userUpdated.otherFields[index] = Field(field, value);
      }

      final hasChanges = userUpdated != IVUser.fromJson(json: originalUser);
      changeState(UserDetailsState.updateUser(
          userUpdated, state.isEditing, hasChanges));
    }
  }

  void _restoreInformation() {
    if (user != null) {
      final restoredUser = IVUser.fromJson(json: originalUser);
      Map userJson = restoredUser.toJson();
      userJson.remove("labels");
      userJson.remove("otherFields");

      for (var value in userJson.entries) {
        _controllers[value.key]?.text = value.value;
      }

      if (restoredUser.otherFields.isNotEmpty) {
        for (var element in user!.otherFields) {
          _controllers[element.name]?.text = element.value;
        }
      }

      changeState(UserDetailsState.updateUser(restoredUser, false, false));
    }
  }

  void cancelEditing() {
    if (_addedControllers.isNotEmpty) {
      _controllers.removeWhere((key, value) => _addedControllers.contains(key));
      _addedControllers = [];
    }

    if (_deletedControllers.isNotEmpty) {
      for (var entry in _deletedControllers.entries) {
        TextEditingController? controller = _deletedControllers[entry.key];
        if (controller != null) {
          _controllers[entry.key] = controller;
        }
      }
    }

    _restoreInformation();
  }

  void startEditing() {
    changeState(
        UserDetailsState.updateUser(state.user, true, state.hasChanged));
  }

  void add({bool isField = true}) {
    if (state.user != null) {
      final name = alertTextFieldController.text;
      alertTextFieldController.text = "";
      IVUser user = state.user!;
      if (isField) {
        _controllers[name] = TextEditingController();
        _addedControllers.add(name);
        user.otherFields.add(Field(name, ""));
      } else {
        Random rnd = Random();
        int index = rnd.nextInt(labelColors.length);
        user.labels.add(Label(name, labelColors[index]));
      }
      changeState(UserDetailsState.updateUser(user, state.isEditing, true));
    }
  }

  void removeField(Field field) {
    IVUser user = state.user!;
    user.otherFields.removeWhere((f) => f.name == field.name);
    TextEditingController? controller = _controllers[field.name];
    if (controller != null) {
      _deletedControllers[field.name] = controller;
    }

    changeState(UserDetailsState.updateUser(user, state.isEditing, true));
  }

  Future<String?> saveChanges() async {
    if (state.user != null) {
      if (formType == FormType.edit) {
        return await _updateUserRepository.update(_id, state.user!);
      } else {
        return await _setUserRepository.set(state.user!);
      }
    }

    return null;
  }

  @override
  void dispose() {
    for (var c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }
}
