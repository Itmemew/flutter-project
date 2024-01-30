import 'package:dio/dio.dart';
import 'package:test_run_app/k_bank/model/model_api.dart';

class DataApi {
  final dio = Dio();

  Future<ModelApi?> getDataApi(
      {required String account, required String money}) async {
    try {
      final response = await dio.post(
        'http://192.168.1.104:8080/api/transferMoney',
        data: {
          'accountNumber': account,
          'amount': money,
        },
      );
      return ModelApi.fromJson(response.data);
    } on DioException catch (e) {
      return null;
    }
  }
}
