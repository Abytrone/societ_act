import 'package:get/state_manager.dart';

class RadioButtonController extends GetxController {
  var selectedGender = "".obs;
  var selectedPartener = "".obs;

// For gender Radio Button
  genderChange(var gender) {
    selectedGender.value = gender;
  }

// For Partener Radio Buttons
  partenerChange(var partener) {
    selectedPartener.value = partener;
  }
}
