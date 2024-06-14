import 'package:dio/dio.dart';
import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../app/routes/route_name.dart';
import '../../../../utils/networking_util.dart';
import '../../../../widgets/snackbar_widget.dart';
import '../../web_page/web_page.dart';

class ProfileController extends GetxController {
  final UserRepository _userRepository;

  final _name = "".obs;

  String get name => _name.value;

  final _phone = "".obs;

  String get phone => _phone.value;

  final _profilePictureUrl = "".obs;

  String get profilePictureUrl => _profilePictureUrl.value;

  var isLoadingDownloadFile = false.obs;

  var isLoadingLogout = false.obs;

  final box = GetStorage();

  ProfileController({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  @override
  void onInit() {
    super.onInit();
    loadUserFromServer();
  }

  void loadUserFromServer() async {
    try {
      final response = await _userRepository.getUser();
      if (response.status == 0) {
        final localUser = response.data;

        _name.value = localUser.name;
        _phone.value = localUser.countryCode.isNotEmpty
            ? "+${localUser.countryCode}${localUser.phone}"
            : "";
        _profilePictureUrl.value = localUser.profilePicture ?? '';
      } else {
        SnackbarWidget.showFailedSnackbar(response.message);
      }
    } catch (error) {
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
    }
  }

  onEditProfileClick() async {
    Get.toNamed(RouteName.editProfile);
  }

  /*
    This Function is used as challenge tester
    DO NOT modify this function
   */
  onTestUnauthenticatedClick() async {
    await _userRepository.testUnauthenticated();
  }

  onDownloadFileClick() async {
    isLoadingDownloadFile.value = true;

    try {
      final dio = Dio();
      const url = 'https://www.tutorialspoint.com/flutter/flutter_tutorial.pdf';
      final dir = await getApplicationDocumentsDirectory();
      final filePath = '${dir.path}/flutter_tutorial.pdf';

      await dio.download(url, filePath);

      SnackbarWidget.showSuccessSnackbar('File downloaded to $filePath');
    } catch (e) {
      SnackbarWidget.showFailedSnackbar('Failed to download file');
    } finally {
      isLoadingDownloadFile.value = false;
    }
  }

  onOpenWebPageClick() {
    Navigator.push(
      Get.context!,
      MaterialPageRoute(
        builder: (context) => WebPage(
            // url: 'https://www.youtube.com/watch?v=lpnKWK-KEYs',
            ),
      ),
    );
  }

  void doLogout() async {
    isLoadingLogout.value = true;
    // Future.delayed(const Duration(seconds: 3), () {
    //   isLoadingLogout.value = false;
    // });

    await _userRepository.logout();

    isLoadingLogout.value = false;
  }
}
