import 'package:get/get.dart';

import '../model/user.dart';
import 'user_pref.dart';

class CurrentUser extends GetxController {
  Rx<User> _currentUser = User(0, '', '', '').obs;

  User get user => _currentUser.value;

  getUserInfo() async {
    //get UserInfo From LocalStorage
    User? getUserInfo = await SaveUserInfo.readUser();
    _currentUser.value = getUserInfo!;
  }
}
