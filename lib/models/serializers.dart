import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:currency/models/amount.dart';
import 'package:currency/models/currency.dart';
import 'package:currency/models/rate.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  Amount,
  Currency,
  Rate,
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
