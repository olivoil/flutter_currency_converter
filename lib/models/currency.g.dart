// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Currency> _$currencySerializer = new _$CurrencySerializer();

class _$CurrencySerializer implements StructuredSerializer<Currency> {
  @override
  final Iterable<Type> types = const [Currency, _$Currency];
  @override
  final String wireName = 'Currency';

  @override
  Iterable serialize(Serializers serializers, Currency object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'symbol',
      serializers.serialize(object.symbol,
          specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  Currency deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CurrencyBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'symbol':
          result.symbol = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Currency extends Currency {
  @override
  final String symbol;
  @override
  final String name;

  factory _$Currency([void updates(CurrencyBuilder b)]) =>
      (new CurrencyBuilder()..update(updates)).build();

  _$Currency._({this.symbol, this.name}) : super._() {
    if (symbol == null) {
      throw new BuiltValueNullFieldError('Currency', 'symbol');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('Currency', 'name');
    }
  }

  @override
  Currency rebuild(void updates(CurrencyBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  CurrencyBuilder toBuilder() => new CurrencyBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Currency && symbol == other.symbol && name == other.name;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, symbol.hashCode), name.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Currency')
          ..add('symbol', symbol)
          ..add('name', name))
        .toString();
  }
}

class CurrencyBuilder implements Builder<Currency, CurrencyBuilder> {
  _$Currency _$v;

  String _symbol;
  String get symbol => _$this._symbol;
  set symbol(String symbol) => _$this._symbol = symbol;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  CurrencyBuilder();

  CurrencyBuilder get _$this {
    if (_$v != null) {
      _symbol = _$v.symbol;
      _name = _$v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Currency other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Currency;
  }

  @override
  void update(void updates(CurrencyBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Currency build() {
    final _$result = _$v ?? new _$Currency._(symbol: symbol, name: name);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
