// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rate.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Rate> _$rateSerializer = new _$RateSerializer();

class _$RateSerializer implements StructuredSerializer<Rate> {
  @override
  final Iterable<Type> types = const [Rate, _$Rate];
  @override
  final String wireName = 'Rate';

  @override
  Iterable serialize(Serializers serializers, Rate object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'base',
      serializers.serialize(object.base, specifiedType: const FullType(String)),
      'date',
      serializers.serialize(object.date, specifiedType: const FullType(String)),
      'rates',
      serializers.serialize(object.rates,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(double)])),
    ];

    return result;
  }

  @override
  Rate deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new RateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'base':
          result.base = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'date':
          result.date = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'rates':
          result.rates.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(double)
              ])) as BuiltMap);
          break;
      }
    }

    return result.build();
  }
}

class _$Rate extends Rate {
  @override
  final String base;
  @override
  final String date;
  @override
  final BuiltMap<String, double> rates;

  factory _$Rate([void updates(RateBuilder b)]) =>
      (new RateBuilder()..update(updates)).build();

  _$Rate._({this.base, this.date, this.rates}) : super._() {
    if (base == null) {
      throw new BuiltValueNullFieldError('Rate', 'base');
    }
    if (date == null) {
      throw new BuiltValueNullFieldError('Rate', 'date');
    }
    if (rates == null) {
      throw new BuiltValueNullFieldError('Rate', 'rates');
    }
  }

  @override
  Rate rebuild(void updates(RateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  RateBuilder toBuilder() => new RateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Rate &&
        base == other.base &&
        date == other.date &&
        rates == other.rates;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, base.hashCode), date.hashCode), rates.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Rate')
          ..add('base', base)
          ..add('date', date)
          ..add('rates', rates))
        .toString();
  }
}

class RateBuilder implements Builder<Rate, RateBuilder> {
  _$Rate _$v;

  String _base;
  String get base => _$this._base;
  set base(String base) => _$this._base = base;

  String _date;
  String get date => _$this._date;
  set date(String date) => _$this._date = date;

  MapBuilder<String, double> _rates;
  MapBuilder<String, double> get rates =>
      _$this._rates ??= new MapBuilder<String, double>();
  set rates(MapBuilder<String, double> rates) => _$this._rates = rates;

  RateBuilder();

  RateBuilder get _$this {
    if (_$v != null) {
      _base = _$v.base;
      _date = _$v.date;
      _rates = _$v.rates?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Rate other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Rate;
  }

  @override
  void update(void updates(RateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Rate build() {
    _$Rate _$result;
    try {
      _$result =
          _$v ?? new _$Rate._(base: base, date: date, rates: rates.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'rates';
        rates.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Rate', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
