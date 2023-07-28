import 'package:iventas_challenge/src/common/models/iv_user.dart';

enum FormType { create, edit }

abstract class UserDetailsState {
  final IVUser? user;
  final bool isEditing;
  final bool hasChanged;

  const UserDetailsState(
      {this.user, this.isEditing = false, this.hasChanged = false});

  factory UserDetailsState.updateUser(
          IVUser? user, bool isEditing, bool hasChanged) =>
      UpdateUserState(user: user, isEditing: isEditing, hasChanged: hasChanged);

  factory UserDetailsState.updateError(
          IVUser user, bool isEditing, String message) =>
      UpdateErrorState(user: user, isEditing: isEditing, message: message);
}

final class UpdateUserState extends UserDetailsState {
  const UpdateUserState(
      {required IVUser? user, required isEditing, required bool hasChanged})
      : super(user: user, isEditing: isEditing, hasChanged: hasChanged);
}

final class UpdateErrorState extends UserDetailsState {
  final String message;

  const UpdateErrorState(
      {required IVUser user, required bool isEditing, required this.message})
      : super(user: user, isEditing: isEditing);
}
