import 'package:skyhigh_app/service/helper.dart';

import '../charts/sales_model.dart';

class DataFetcher {
  final NetworkHelper _networkHelper = NetworkHelper();

  Future<List<SalesModel>> fetchData() async {
    try {
      var response = await _networkHelper.post(
          'https://g54qw205uk.execute-api.eu-west-1.amazonaws.com/DEV/stub',
          {"angular_test": "angular-developer"});
      return salesModelFromJson(response.body);
    } catch (e) {
      print('Error fetching data: $e');
      throw e;
    }
  }
}
