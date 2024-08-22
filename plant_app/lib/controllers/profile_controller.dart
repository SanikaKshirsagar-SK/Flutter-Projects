import 'package:get/get.dart';
import '../model/user_model.dart';
import 'database_controller.dart';

class ProfileController extends GetxController {
  final _userData = UserModel(name: "", username: "", password: "").obs;
  final DatabaseController _databaseController = Get.find();

  UserModel get userData => _userData.value;

  @override
  void onInit() {
    super.onInit();
    loadCredentials();
  }

void loadCredentials() async {
  if (_loggedInUser != null) {
    _userData.value = _loggedInUser!;
    update();
  } else {
    final userDataList = await _databaseController.fetchUserData();
    if (userDataList.isNotEmpty) {
      _userData.value = userDataList.first;
      update();
    }
  }
}

  UserModel? _loggedInUser;
  UserModel? get loggedInUser => _loggedInUser;

  void setLoggedInUser(UserModel? user) {
    _loggedInUser = user;
    update();
  }

  void loadLoggedInUserCredentials() async {
  if (_loggedInUser != null) {
    _userData.value = _loggedInUser!;
    update();
  }
}

  void fetchAndSetUserData(String username, String password) async {
    final userDataList = await _databaseController.fetchUserData();
    if (userDataList.isNotEmpty) {
      for (var userData in userDataList) {
        if (userData.username == username && userData.password == password) {
          _userData.value = userData;
          update();
          return;
        }
      }
    }
    _userData.value = UserModel(name: "", username: "", password: "");
    update();
  }

  // @override
  // void dispose() {
  //   _userData.close();
  //   super.dispose();
  // }
}
