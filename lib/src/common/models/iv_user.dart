import 'dart:convert';

import 'package:iventas_challenge/src/common/models/field.dart';
import 'package:iventas_challenge/src/common/models/label.dart';

final class IVUser {
  String id = "";
  final String name;
  final String lastname;
  final String email;
  final String image =
      "https://cdn.iconscout.com/icon/free/png-256/free-avatar-370-456322.png?f=webp";
  final String phone;
  final List<Label> labels;
  final List<Field> otherFields;

  IVUser(this.name, this.lastname, this.email, this.phone, this.labels,
      this.otherFields);

  factory IVUser.fromJson({required String id, required dynamic json}) {
    final List<dynamic> jsonLabels = json['labels'];
    final List<dynamic> jsonFields = json['otherFields'];
    final List<Label> labels =
        jsonLabels.map((l) => Label.fromJson(l)).toList();
    final List<Field> fields =
        jsonFields.map((f) => Field.fromJson(f)).toList();
    return IVUser(json['name'], json['lastname'], json['email'], json['phone'],
        labels, fields);
  }

  Map<String, dynamic> toJson() {
    final List<dynamic> jsonLabels = labels.map((e) => e.toJson()).toList();
    final List<dynamic> jsonFields =
        otherFields.map((e) => e.toJson()).toList();
    return {
      "name": name,
      "lastname": lastname,
      "email": email,
      "image": image,
      "phone": phone,
      "labels": jsonLabels,
      "otherFields": jsonFields
    };
  }
}
