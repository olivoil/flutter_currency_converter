// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'amount.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Amount> _$amountSerializer = new _$AmountSerializer();

class _$AmountSerializer implements StructuredSerializer<Amount> {
  @override
  final Iterable<Type> types = const [Amount, _$Amount];
  @override
  final String wireName = 'Amount';

  @override
  Iterable serialize(Serializers serializers, Amount object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'value',
      serializers.serialize(object.value,
          specifiedType: const FullType(double)),
      'currency',
      serializers.serialize(object.currency,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  Amount deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AmountBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'value':
          result.value = serializers.deserialize(value,
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

class _$Amount extends Amount {
  @override
  final double value;
  @override
  final String currency;

  factory _$Amount([void updates(AmountBuilder b)]) =>
      (new AmountBuilder()..update(updates)).build();

  _$Amount._({this.value, this.currency}) : super._() {
    if (value == null) {
      throw new BuiltValueNullFieldError('Amount', 'value');
    }
    if (currency == null) {
      throw new BuiltValueNullFieldError('Amount', 'currency');
    }
  }

  @override
  Amount rebuild(void updates(AmountBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  AmountBuilder toBuilder() => new AmountBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Amount &&
        value == other.value &&
        currency == other.currency;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, value.hashCode), currency.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Amount')
          ..add('value', value)
          ..add('currency', currency))
        .toString();
  }
}

class AmountBuilder implements Builder<Amount, AmountBuilder> {
  _$Amount _$v;

  double _value;
  double get value => _$this._value;
  set value(double value) => _$this._value = value;

  String _currency;
  String get currency => _$this._currency;
  set currency(String currency) => _$this._currency = currency;

  AmountBuilder();

  AmountBuilder get _$this {
    if (_$v != null) {
      _value = _$v.value;
      _currency = _$v.currency;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Amount other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Amount;
  }

  @override
  void update(void updates(AmountBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Amount build() {
    final _$result = _$v ?? new _$Amount._(value: value, currency: currency);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
