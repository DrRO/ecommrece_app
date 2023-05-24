import 'package:ecommrece_app/registration_api_connection/users/user_preferences/current_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/user.dart';

class DashboardOfFragment extends StatelessWidget {
  CurrentUser _rememberCurrentUser = Get.put(CurrentUser());

  DashboardOfFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: CurrentUser(),
        initState: (currentState) {
          _rememberCurrentUser.getUserInfo();
        },
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Dashboard"),
            ),
          );
        }
    );
  }
}
