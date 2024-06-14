import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:entrance_test/src/utils/networking_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../../app/routes/route_name.dart';
import '../../../widgets/snackbar_widget.dart';

class LoginController extends GetxController {
  final UserRepository _userRepository;

  LoginController({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  final etCountryCode = TextEditingController();
  final etPhone = TextEditingController();
  final etPassword = TextEditingController();

  final tokenController = TextEditingController();
  final box = GetStorage();

  final obscureText = true.obs;
  final key = GlobalKey<FormState>();

  var isLoadingLogin = false.obs;

  // final TextEditingController controllerCode = TextEditingController();
  // String initialCountry = 'ID';
  // PhoneNumber number = PhoneNumber(isoCode: 'ID');

  // FocusNode focusNode = FocusNode();

  void doLogin() async {
    isLoadingLogin.value = true;
    // if (etPhone.text != '85173254399' || etPassword.text != '12345678') {
    //   SnackbarWidget.showFailedSnackbar('Email atau password salah');
    //   Future.delayed(const Duration(seconds: 3), () {
    //     isLoadingLogin.value = false;
    //   });
    //   return;
    // }
    try {
      final data = await _userRepository.login(
          etPhone.text, etPassword.text, etCountryCode.text);
    } catch (error) {
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
    }

    isLoadingLogin.value = false;
  }

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }
}
