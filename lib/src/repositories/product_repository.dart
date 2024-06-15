import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import '../constants/endpoint.dart';
import '../models/product_model.dart';
import '../models/request/product_list_request_model.dart';
import '../models/response/product_list_response_model.dart';
import '../utils/networking_util.dart';

class ProductRepository {
  final Dio _client;
  final GetStorage _local;

  ProductRepository({required Dio client, required GetStorage local})
      : _client = client,
        _local = local;

  final box = GetStorage();

  Future<ProductListResponseModel> getProductList(
      ProductListRequestModel request) async {
    try {
      String endpoint = Endpoint.getProductList;
      print('data request ${request}');
      final responseJson = await _client.get(
        endpoint,
        data: request,
        options:
            NetworkingUtil.setupNetworkOptions('Bearer ${box.read('token')}'),
      );
      return ProductListResponseModel.fromJson(responseJson.data);
    } on DioError catch (_) {
      rethrow;
    }
  }

  Future<ProductModel> getProductDetail(String productId) async {
    print("code response ${productId}");
    try {
      final response = await _client.get(
        'http://develop-at.vesperia.id:1091/api/v1/product/$productId',
        options:
            NetworkingUtil.setupNetworkOptions('Bearer ${box.read('token')}'),
      );
      print("code response ${response}");
      return ProductModel.fromJson(response.data['data']);
    } on DioError catch (_) {
      rethrow;
    }
  }
}
