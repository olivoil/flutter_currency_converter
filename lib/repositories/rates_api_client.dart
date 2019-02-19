import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:currency/models/rate.dart';
import 'package:currency/models/serializers.dart';

class RatesApiClient {
  static const baseUrl = 'https://api.exchangeratesapi.io';
  final http.Client httpClient;

  RatesApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<Rate> fetchLatestRates() async {
    final url = '$baseUrl/latest?base=USD';
    final res = await this.httpClient.get(url);

    if (res.statusCode != 200) {
      throw Exception('error getting exchange rates');
    }

    print(res.body);
    print(json.decode(res.body));
    return serializers.deserializeWith(Rate.serializer, json.decode(res.body));
  }
}
