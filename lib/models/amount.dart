import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:currency/models/serializers.dart';

part 'amount.g.dart';

abstract class Amount implements Built<Amount, AmountBuilder> {
  Amount._();

  factory Amount([updates(AmountBuilder b)]) = _$Amount;

  @BuiltValueField(wireName: 'value')
  double get value;

  @BuiltValueField(wireName: 'currency')
  String get currency;

  static Amount fromJson(dynamic val) {
    return serializers.deserialize(val, specifiedType: FullType(Amount));
  }

  String toJson() {
    return json
        .encode(serializers.serialize(this, specifiedType: FullType(Amount)));
  }

  static Amount zero(String symbol) {
    return Amount((b) => b
      ..value = 0.0
      ..currency = symbol);
  }

  static Serializer<Amount> get serializer => _$amountSerializer;
}
