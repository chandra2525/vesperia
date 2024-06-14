// import 'package:entrance_test/src/repositories/user_repository.dart';
// import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../constants/image.dart';

// import '../../../../app/routes/route_name.dart';
// import '../../../repositories/user_repository.dart';
// import '../../../widgets/snackbar_widget.dart';

class BoardingController extends GetxController {
  var currentIndex = 0.obs;
  PageController pageController = PageController();

  final List<Map<String, String>> onboardingData = [
    {
      'image': boardingImage1,
      'title': 'Welcome to App',
      'content':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
    },
    {
      'image': boardingImage2,
      'title': 'Explore Features',
      'content':
          'Vivamus lacinia odio vitae vestibulum vestibulum. Vivamus lacinia odio vitae vestibulum vestibulum. Vivamus lacinia odio vitae vestibulum vestibulum.'
    },
    {
      'image': boardingImage3,
      'title': 'Get Started',
      'content':
          'Cras justo odio, dapibus ac facilisis in, egestas eget quam. Cras justo odio, dapibus ac facilisis in, egestas eget quam.'
    },
    {
      'image': boardingImage4,
      'title': 'Our Affiliation',
      'content':
          'We offer a wide range of skincare products from trusted brands that are designed to help you achieve healthy, beautiful, and glowing skin.'
    }
  ];

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    setOnboardingSeen();
  }

  void setIndex(int index) {
    currentIndex.value = index;
  }

  Future<void> setOnboardingSeen() async {
    box.write('onboardingSeen', true);
  }

  Future<bool> isOnboardingSeen() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // return prefs.getBool('onboardingSeen') ?? false;

    // final isLoggedIn = box.read('token') != null;

    // Get.offAllNamed(isLoggedIn ? RouteName.dashboard : RouteName.login);
    // return false;
    return box.read('onboardingSeen') ?? false;
  }

  void nextPage() {
    pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
