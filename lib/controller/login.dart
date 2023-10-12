import 'dart:convert';

import 'package:flutter_app/utils/exports.dart';
import 'package:http/http.dart' as http;

class LoginController with ChangeNotifier {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  bool _showpassword = true;
  bool get showpassword => _showpassword;

  changeShowPassword() {
    _showpassword = !showpassword;
    notifyListeners();
  }

  Future<void> UserLoginApi () async {
    final response = await http.post(
      Uri.parse(
          'http://trial.weberfox.in/task/api/user-login'),
      
            body: {
        "username": username.text,
        "password": password.text,
      },
    );
    try {
      if (response.statusCode == 200) {
        final responseLogin = jsonDecode(response.body);
        print("Success");
        Get.to(
            ProfileDetailScreen()); // if connected successfull it will go to loginScreen
      } else {
        throw Exception();
      }
    } catch (e) {
      print(e);
    }
  }
}