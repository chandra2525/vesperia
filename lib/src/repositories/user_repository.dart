import 'package:dio/dio.dart';
import 'package:entrance_test/app/routes/route_name.dart';
import 'package:entrance_test/src/constants/local_data_key.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../constants/endpoint.dart';
import '../models/response/user_response_model.dart';
import '../utils/networking_util.dart';
import '../widgets/snackbar_widget.dart';

class UserRepository {
  final Dio _client;
  final GetStorage _local;

  UserRepository({required Dio client, required GetStorage local})
      : _client = client,
        _local = local;

  final box = GetStorage();

  Future<void> login(etPhone, etPassword, etCountryCode) async {
    //Artificial delay to simulate logging in process
    // await Future.delayed(const Duration(seconds: 2));
    //Placeholder token. DO NOT call real logout API using this token
    // _local.write(
    //     LocalDataKey.token, "621|DBiUBMfsEtX01tbdu4duNRCNMTt7PV5blr6zxTvq");
    var body = {
      "phone_number": etPhone,
      "password": etPassword,
      // "phone_number": "85173254399",
      // "password": '12345678',
      "country_code": etCountryCode
    };
    try {
      final responseJson = await _client.post(
        Endpoint.signIn,
        queryParameters: body,
        // options: NetworkingUtil.setupNetworkOptions(
        //     'Bearer ${_local.read(LocalDataKey.token)}'),
      );
      final data = responseJson.data;

      print("data user ${responseJson.statusCode.toString()}");
      if (responseJson.statusCode == 200) {
        var token = data['data']['token'];
        box.write('token', token);
        box.write('phone', etPhone);
        // box.write('password', etPassword);

        Get.offAllNamed(RouteName.dashboard);
      } else {
        SnackbarWidget.showFailedSnackbar(
            NetworkingUtil.errorMessage(data['message']));
      }
    } on DioError catch (_) {
      rethrow;
    }
  }

  Future<void> logout() async {
    //Artificial delay to simulate logging out process
    // await Future.delayed(const Duration(seconds: 2));
    print(box.read('token'));

    try {
      final responseJson = await _client.post(
        Endpoint.signOut,
        // queryParameters: body,
        options:
            NetworkingUtil.setupNetworkOptions('Bearer ${box.read('token')}'),
      );
      final data = responseJson.data;

      print("data user ${data}");
      if (responseJson.statusCode == 200) {
        await _local.remove(LocalDataKey.token);

        box.remove('token');
        box.remove('phone');
        Get.offAllNamed(RouteName.login);
      } else {
        SnackbarWidget.showFailedSnackbar(
            NetworkingUtil.errorMessage(data['message']));
      }
    } on DioError catch (_) {
      rethrow;
    }
  }

  Future<UserResponseModel> getUser() async {
    try {
      final responseJson = await _client.get(
        Endpoint.getUser,
        options:
            NetworkingUtil.setupNetworkOptions('Bearer ${box.read('token')}'),
      );

      print("data user ${responseJson.data}");
      final model = UserResponseModel.fromJson(responseJson.data);
      return model;
    } on DioException catch (_) {
      rethrow;
    }
  }

  /*
    This Function is used as challenge tester
    DO NOT modify this function
   */
  Future<void> testUnauthenticated() async {
    try {
      final realToken = _local.read<String?>(LocalDataKey.token);
      await _local.write(
          LocalDataKey.token, '619|kM5YBY5yM15KEuSmSMaEzlfv0lWs83r4cp4oty2T');
      getUser();
      //401 not caught as exception
      await _local.write(LocalDataKey.token, realToken);
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<void> saveProfile(etFullName, etEmail, gender, etHeight, etWeight,
      etBirthDate, profilePicture) async {
    var body = {
      "name": etFullName,
      "email": etEmail,
      "gender": gender,
      "date_of_birth": etBirthDate,
      "height": etHeight,
      "weight": etWeight,
      // "profile_picture": profilePicture,
      "_method": 'PUT',
    };
    print("data user ${body}");
    try {
      final responseJson = await _client.post(
        Endpoint.editUser,
        queryParameters: body,
        options:
            NetworkingUtil.setupNetworkOptions('Bearer ${box.read('token')}'),
      );

      final data = responseJson.data;

      print("data user ${responseJson.statusCode.toString()}");
      print("data user ${data}");
      if (responseJson.statusCode == 200) {
        SnackbarWidget.showSuccessSnackbar('Profile saved successfully');
      } else {
        SnackbarWidget.showFailedSnackbar(
            NetworkingUtil.errorMessage(data['message']));
      }
    } on DioError catch (_) {
      rethrow;
    }
  }
}
