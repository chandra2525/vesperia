import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../constants/color.dart';
import '../../constants/icon.dart';
import '../../widgets/button_icon.dart';
import 'component/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          title: const Text(
            "Sign In",
            style: TextStyle(
              fontSize: 16,
              color: gray900,
              fontWeight: FontWeight.w600,
            ),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
          ),
          child: Form(
            key: controller.key,
            child: Column(
              children: [
                const SizedBox(height: 16),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Hi, Welcome Back",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Sign in to your account.',
                    style: TextStyle(
                      fontSize: 16,
                      color: gray500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Phone Number',
                                  style: TextStyle(color: gray900),
                                ),
                                TextSpan(
                                  text: ' *',
                                  style: TextStyle(color: red500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    IntlPhoneField(
                      disableAutoFillHints: true,
                      disableLengthCheck: true,
                      // focusNode: controller.focusNode,
                      validator: (phone) {
                        if (phone!.number.length < 8 ||
                            phone.number.length > 16) {
                          return "Phone number length can't be less than 8 or more than 16";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^[1-9][0-9]*$')),
                      ],
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: gray900),
                      cursorColor: primary,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide:
                              const BorderSide(color: gray200, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide:
                              const BorderSide(color: gray200, width: 1.5),
                        ),
                        fillColor: white,
                        filled: true,
                        hintText: 'Phone Number',
                        prefixIcon: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(width: 6),
                              Text(
                                '+62',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: gray900),
                              ),
                              SizedBox(width: 12),
                              SizedBox(
                                width: 1.5,
                                height: 48,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(color: gray100),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      controller: controller.etPhone,
                      languageCode: "id",
                      initialCountryCode: 'ID',
                      onChanged: (phone) {
                        print(phone.completeNumber);
                        print(phone.countryCode);
                        print(controller.etPhone.text);
                        controller.etCountryCode.text =
                            phone.countryCode.replaceAll('+', '');
                        print(controller.etCountryCode.text);
                      },
                      onCountryChanged: (country) {
                        print('Country changed to: ' + country.name);
                        print('Country changed to: ' + country.dialCode);

                        controller.etCountryCode.text = country.dialCode;
                        print(controller.etCountryCode.text);
                      },
                    ),
                    // InternationalPhoneNumberInput(
                    //   validator: (value) {
                    //     if (value!.length < 8 || value.length > 16) {
                    //       return "Phone number length can't be less than 8 or more than 16";
                    //     } else {
                    //       return null;
                    //     }
                    //   },
                    //   onInputChanged: (PhoneNumber number) {
                    //     print(number.phoneNumber);
                    //   },
                    //   onInputValidated: (bool value) {
                    //     print(value);
                    //   },
                    //   selectorConfig: SelectorConfig(
                    //     selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    //     useBottomSheetSafeArea: true,
                    //   ),
                    //   ignoreBlank: false,
                    //   autoValidateMode: AutovalidateMode.disabled,
                    //   selectorTextStyle: TextStyle(color: Colors.black),
                    //   initialValue: controller.number,
                    //   textFieldController: controller.controllerCode,
                    //   formatInput: true,
                    //   keyboardType: TextInputType.numberWithOptions(
                    //       signed: true, decimal: true),
                    //   inputBorder: OutlineInputBorder(),
                    //   onSaved: (PhoneNumber number) {
                    //     print('On Saved: $number');
                    //   },
                    // ),
                    // TextFormField(
                    //   validator: (value) {
                    //     if (value!.length < 8 || value.length > 16) {
                    //       return "Phone number length can't be less than 8 or more than 16";
                    //     } else {
                    //       return null;
                    //     }
                    //   },
                    //   keyboardType: TextInputType.phone,
                    //   inputFormatters: [
                    //     FilteringTextInputFormatter.digitsOnly,
                    //     FilteringTextInputFormatter.allow(
                    //         RegExp(r'^[1-9][0-9]*$')),
                    //   ],
                    //   textAlign: TextAlign.start,
                    //   style: const TextStyle(
                    //       fontSize: 14,
                    //       fontWeight: FontWeight.w600,
                    //       color: gray900),
                    //   cursorColor: primary,
                    //   decoration: InputDecoration(
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(8.0),
                    //       borderSide:
                    //           const BorderSide(color: gray200, width: 1.5),
                    //     ),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(8.0),
                    //       borderSide:
                    //           const BorderSide(color: gray200, width: 1.5),
                    //     ),
                    //     fillColor: white,
                    //     filled: true,
                    //     hintText: 'Phone Number',
                    //     prefixIcon: const Padding(
                    //       padding: EdgeInsets.symmetric(horizontal: 14.0),
                    //       child: Row(
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         mainAxisSize: MainAxisSize.min,
                    //         children: [
                    //           SizedBox(width: 6),
                    //           Text(
                    //             '+62',
                    //             style: TextStyle(
                    //                 fontSize: 14,
                    //                 fontWeight: FontWeight.w600,
                    //                 color: gray900),
                    //           ),
                    //           SizedBox(width: 12),
                    //           SizedBox(
                    //             width: 1.5,
                    //             height: 48,
                    //             child: DecoratedBox(
                    //               decoration: BoxDecoration(color: gray100),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    //   controller: controller.etPhone,
                    // ),
                  ],
                ),
                const SizedBox(height: 24),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Password',
                                  style: TextStyle(color: gray900),
                                ),
                                TextSpan(
                                  text: ' *',
                                  style: TextStyle(color: red500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Obx(
                      () => TextFormField(
                        validator: (value) {
                          if (value!.length < 8) {
                            return "Password length can't be less than 8";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.visiblePassword,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: gray900),
                        obscureText: controller.obscureText.value,
                        cursorColor: primary,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                            left: 12,
                            right: -14,
                            top: 20,
                            bottom: 20,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide:
                                const BorderSide(color: gray200, width: 1.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide:
                                const BorderSide(color: gray200, width: 1.5),
                          ),
                          fillColor: white,
                          filled: true,
                          hintText: 'Password',
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(14.0),
                            child: ImageIcon(
                              AssetImage(ic_password),
                            ), // icon is 48px widget.
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: IconButton(
                              icon: Icon(controller.obscureText.value
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                controller.toggleObscureText();
                              },
                            ),
                          ),
                        ),
                        controller: controller.etPassword,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                loginButton(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loginButton() => Obx(
        () => controller.isLoadingLogin.value
            ? const CircularProgressIndicator()
            : SizedBox(
                height: 52,
                width: double.infinity,
                child: SizedBox(
                  height: 52,
                  width: double.infinity,
                  child: ButtonIcon(
                    buttonColor: primary,
                    textColor: white,
                    textLabel: "Sign In",
                    onClick: () {
                      final form = controller.key.currentState;
                      if (form!.validate()) {
                        form.save();
                        controller.doLogin();
                      }
                    },
                  ),
                )),
      );
}
