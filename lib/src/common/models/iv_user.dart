import 'dart:convert';

import 'package:iventas_challenge/src/common/models/field.dart';
import 'package:iventas_challenge/src/common/models/label.dart';

final class IVUser {
  String id;
  final String name;
  final String lastname;
  final String email;
  final String image =
      "https://cdn.iconscout.com/icon/free/png-256/free-avatar-370-456322.png?f=webp";
  final String phone;
  final List<Label> labels;
  final List<Field> otherFields;

  IVUser(this.id, this.name, this.lastname, this.email, this.phone, this.labels,
      this.otherFields);

  factory IVUser.fromJson({required dynamic json}) {
    List<dynamic> jsonLabels = [];
    List<dynamic> jsonFields = [];
    List<Label> labels = [];
    List<Field> fields = [];

    if (json['labels'] != null) {
      jsonLabels = json['labels'];
    }

    if (json['otherFields'] != null) {
      jsonFields = json['otherFields'];
    }

    if (jsonFields.isNotEmpty) {
      fields = jsonFields.map((f) => Field.fromJson(f)).toList();
    }

    if (jsonLabels.isNotEmpty) {
      labels = jsonLabels.map((l) => Label.fromJson(l)).toList();
    }
    return IVUser(json['id'], json['name'], json['lastname'], json['email'],
        json['phone'], labels, fields);
  }

  Map<String, dynamic> toJson() {
    final List<dynamic> jsonLabels = labels.map((e) => e.toJson()).toList();
    final List<dynamic> jsonFields =
        otherFields.map((e) => e.toJson()).toList();
    return {
      "id": id,
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
