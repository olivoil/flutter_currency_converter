import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:currency/models/serializers.dart';

part 'value.g.dart';

abstract class Value implements Built<Value, ValueBuilder> {
  Value._();

  factory Value([updates(ValueBuilder b)]) = _$Value;

  @BuiltValueField(wireName: 'amount')
  double get amount;

  @BuiltValueField(wireName: 'currency')
  String get currency;

  static Value fromJson(dynamic val) {
    return serializers.deserialize(val, specifiedType: FullType(Value));
  }

  String toJson() {
    return json
        .encode(serializers.serialize(this, specifiedType: FullType(Value)));
  }

  static Value zero(String symbol) {
    return Value((b) => b
      ..amount = 0.0
      ..currency = symbol);
  }

  static Value one(String symbol) {
    return Value((b) => b
      ..amount = 1.0
      ..currency = symbol);
  }

  static Serializer<Value> get serializer => _$valueSerializer;
}
