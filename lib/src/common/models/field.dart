final class Field {
  final String name;
  final String value;

  Field(this.name, this.value);

  factory Field.fromJson(json) {
    return Field(json['name'], json['value']);
  }

  Map<String, dynamic> toJson() => {"name": name, "value": value};
}
