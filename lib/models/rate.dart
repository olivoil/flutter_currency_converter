import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:currency/models/serializers.dart';

part 'rate.g.dart';

abstract class Rate implements Built<Rate, RateBuilder> {
  Rate._();

  factory Rate([updates(RateBuilder b)]) = _$Rate;

  @BuiltValueField(wireName: 'base')
  String get base;

  @BuiltValueField(wireName: 'date')
  String get date;

  @BuiltValueField(wireName: 'rates')
  BuiltMap<String, double> get rates;

  static Rate fromJson(dynamic val) {
    return serializers.deserialize(val, specifiedType: FullType(Rate));
  }

  String toJson() {
    return json
        .encode(serializers.serialize(this, specifiedType: FullType(Rate)));
  }

  static Serializer<Rate> get serializer => _$rateSerializer;
}
