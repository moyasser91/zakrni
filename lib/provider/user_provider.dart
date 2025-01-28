import 'package:flutter/cupertino.dart';

import '../data_model/my_user_model.dart';

class UserProvider extends ChangeNotifier {
  MyUserModel? updateUserModel;

  void updateUser(MyUserModel? newUpdateUser) {
    updateUserModel = newUpdateUser;
    notifyListeners();
  }
}
