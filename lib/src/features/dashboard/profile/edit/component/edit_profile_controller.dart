import 'dart:typed_data';

import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:entrance_test/src/utils/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../constants/color.dart';
import '../../../../../utils/date_util.dart';
import '../../../../../utils/networking_util.dart';
import '../../../../../widgets/snackbar_widget.dart';
import '../../component/profile_controller.dart';

class EditProfileController extends GetxController {
  final UserRepository _userRepository;

  EditProfileController({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  final etFullName = TextEditingController();
  final etPhoneNumber = TextEditingController();
  final etEmail = TextEditingController();
  final etHeight = TextEditingController();
  final etWeight = TextEditingController();
  final etBirthDate = TextEditingController();
  String etBirthDateSend = '';

  final _countryCode = "".obs;

  String get countryCode => _countryCode.value;

  final _gender = ''.obs;

  String get gender => _gender.value;

  final _profilePictureUrlOrPath = ''.obs;

  String get profilePictureUrlOrPath => _profilePictureUrlOrPath.value;

  final _isLoadPictureFromPath = false.obs;

  bool get isLoadPictureFromPath => _isLoadPictureFromPath.value;

  final _isGenderFemale = false.obs;

  bool get isGenderFemale => _isGenderFemale.value;

  DateTime birthDate = DateTime.now();

  final key = GlobalKey<FormState>();

  var isLoadingSaveData = false.obs;

  // Inject EditProfileController
  final ProfileController profileController =
      Get.put(ProfileController(userRepository: Get.find<UserRepository>()));

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
        etFullName.text = localUser.name;
        etPhoneNumber.text = localUser.phone;
        etEmail.text = localUser.email ?? '';
        etHeight.text = localUser.height?.toString() ?? '';
        etWeight.text = localUser.weight?.toString() ?? '';

        _countryCode.value = localUser.countryCode;

        _profilePictureUrlOrPath.value = localUser.profilePicture ?? '';
        _isLoadPictureFromPath.value = false;

        _gender.value = localUser.gender ?? '';
        if (gender.isNullOrEmpty || gender == 'laki_laki') {
          onChangeGender(false);
        } else {
          onChangeGender(true);
        }

        etBirthDate.text = '';
        if (localUser.dateOfBirth.isNullOrEmpty == false) {
          birthDate =
              DateUtil.getDateFromShortServerFormat(localUser.dateOfBirth!);
          etBirthDate.text = DateUtil.getBirthDate(birthDate);
        }

        etBirthDateSend = DateUtil.sendBirthDate(birthDate);
      } else {
        SnackbarWidget.showFailedSnackbar(response.message);
      }
    } catch (error) {
      error.printError();
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
    }
  }

  Future<void> showConfirmationDialog(
      String title, String message, BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: gray900,
              fontWeight: FontWeight.w600,
            ),
          ),
          // content: SingleChildScrollView(
          //   child: ListBody(
          //     children: <Widget>[
          //       Text(message),
          //     ],
          //   ),
          // ),
          actions: <Widget>[
            TextButton(
              child: const Text('Camera'),
              onPressed: () {
                Navigator.of(context).pop();
                pickImage('camera');
              },
            ),
            TextButton(
              child: const Text(
                'Gallery',
              ),
              onPressed: () {
                Navigator.of(context).pop();
                pickImage('gallery');
              },
            ),
          ],
        );
      },
    );
  }

  final _profilePicture = Rxn<Uint8List>();

  Future<void> pickImage(tipe) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
        source: tipe == 'gallery' ? ImageSource.gallery : ImageSource.camera);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      _profilePicture.value = bytes;
      _profilePictureUrlOrPath.value = pickedFile.path;
      _isLoadPictureFromPath.value = true;
    } else {
      Get.snackbar(
        'Error',
        'No image selected',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void changeImage() async {
    showConfirmationDialog('Select image source', '', Get.context!);
  }

  void onChangeGender(bool isFemale) {
    if (isFemale) {
      _gender.value = 'perempuan';
    } else {
      _gender.value = 'laki_laki';
    }
    _isGenderFemale.value = isFemale;
  }

  void onChangeBirthDate(DateTime dateTime) {
    birthDate = dateTime;
    etBirthDate.text = DateUtil.getBirthDate(birthDate);
    etBirthDateSend = DateUtil.sendBirthDate(birthDate);

    print(etBirthDateSend);
  }

  void saveData() async {
    isLoadingSaveData.value = true;
    // if (etPhone.text != '85173254399' || etPassword.text != '12345678') {
    //   SnackbarWidget.showFailedSnackbar('Email atau password salah');
    //   Future.delayed(const Duration(seconds: 3), () {
    //     isLoadingSaveData.value = false;
    //   });
    //   return;
    // }
    try {
      await _userRepository.saveProfile(
          etFullName.text,
          etEmail.text,
          _gender.value,
          etHeight.text,
          etWeight.text,
          etBirthDateSend,
          _profilePicture.value);
    } catch (error) {
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
    }

    isLoadingSaveData.value = false;
  }
}
