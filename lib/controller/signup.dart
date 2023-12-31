import 'dart:convert';
import 'dart:js';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/utils/exports.dart';

class SignUpController with ChangeNotifier {
  TextEditingController username = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  bool _showpassword = true;
  bool _showcnfrmpassword = true;

  bool get showpassword => _showpassword;
  bool get showcnfrmpassword => _showcnfrmpassword;

  Future<void> EmailRegistration() async {
    final response = await http.post(
      Uri.parse('http://trial.weberfox.in/task/api/user-signup'),
      body: {
        "name": name.text,
        "username": username.text,
        "email": email.text.trim(),
        "phone_number": phone.text,
        "password": password.text,
        "ConfirmPassword": confirmpassword.text,
      },
    );
    try {
      if (response.statusCode == 200) {
        final responseSignUp = jsonDecode(response.body);
        print("Succesful!");
        Get.to(LoginScreen());
      } else {
        throw Exception();
      }
    } catch (error) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text("Error"),
              contentPadding: EdgeInsets.all(15),
              children: [
                Text(error.toString()),
              ],
            );
          });
      //print(error);
    }
  }

  void changeShowPassword() {
    _showpassword = !showpassword;
    notifyListeners();
  }

  void changeShowCnfrmPassword() {
    _showcnfrmpassword = !_showcnfrmpassword;
    notifyListeners();
  }
}
