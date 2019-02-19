import 'package:meta/meta.dart';

import 'package:currency/repositories/rates_api_client.dart';
import 'package:currency/models/models.dart';

class RatesRepository {
  final RatesApiClient rateApiClient;

  RatesRepository({@required this.rateApiClient})
      : assert(rateApiClient != null);

  Future<Rate> fetchLatestRates() async {
    return await rateApiClient.fetchLatestRates();
  }
}
