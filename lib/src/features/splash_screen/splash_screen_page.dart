import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../constants/color.dart';
import '../../constants/icon.dart';
// import '../../widgets/button_icon.dart';
import 'component/splash_screen_controller.dart';

class SplashScreenPage extends GetView<SplashScreenController> {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[splashScrrenColor1, splashScrrenColor2],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '',
              style: TextStyle(fontSize: 22),
            ),
            Image.asset(
              // color: Colors.transparent,
              width: 200.0,
              height: 200.0,
              ic_app,
              fit: BoxFit.fill,
            ),
            SafeArea(
              child: Obx(
                () => Text(
                  'Ver: ${controller.version.value}',
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: gray900),
                ),
              ),
            ),
          ],
        ), //
      ),
    );
  }
}
