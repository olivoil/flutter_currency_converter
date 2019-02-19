// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'value.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Value> _$valueSerializer = new _$ValueSerializer();

class _$ValueSerializer implements StructuredSerializer<Value> {
  @override
  final Iterable<Type> types = const [Value, _$Value];
  @override
  final String wireName = 'Value';

  @override
  Iterable serialize(Serializers serializers, Value object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'amount',
      serializers.serialize(object.amount,
          specifiedType: const FullType(double)),
      'currency',
      serializers.serialize(object.currency,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  Value deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ValueBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'amount':
          result.amount = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'currency':
          result.currency = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Value extends Value {
  @override
  final double amount;
  @override
  final String currency;

  factory _$Value([void updates(ValueBuilder b)]) =>
      (new ValueBuilder()..update(updates)).build();

  _$Value._({this.amount, this.currency}) : super._() {
    if (amount == null) {
      throw new BuiltValueNullFieldError('Value', 'amount');
    }
    if (currency == null) {
      throw new BuiltValueNullFieldError('Value', 'currency');
    }
  }

  @override
  Value rebuild(void updates(ValueBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ValueBuilder toBuilder() => new ValueBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Value &&
        amount == other.amount &&
        currency == other.currency;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, amount.hashCode), currency.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Value')
          ..add('amount', amount)
          ..add('currency', currency))
        .toString();
  }
}

class ValueBuilder implements Builder<Value, ValueBuilder> {
  _$Value _$v;

  double _amount;
  double get amount => _$this._amount;
  set amount(double amount) => _$this._amount = amount;

  String _currency;
  String get currency => _$this._currency;
  set currency(String currency) => _$this._currency = currency;

  ValueBuilder();

  ValueBuilder get _$this {
    if (_$v != null) {
      _amount = _$v.amount;
      _currency = _$v.currency;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Value other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Value;
  }

  @override
  void update(void updates(ValueBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Value build() {
    final _$result = _$v ?? new _$Value._(amount: amount, currency: currency);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
