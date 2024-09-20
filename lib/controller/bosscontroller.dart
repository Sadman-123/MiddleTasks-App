import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:untitled4/controller/screens/login.dart';
import 'dart:convert';
import 'package:untitled4/controller/screens/todo.dart';
class Bosscontroller extends GetxController {
  TextEditingController regname = TextEditingController();
  TextEditingController regpass = TextEditingController();
  TextEditingController loginname = TextEditingController();
  TextEditingController loginpass = TextEditingController();
  TextEditingController todoadd = TextEditingController();
  RxList<dynamic> arr = <dynamic>[].obs;
  RxBool isLoading=true.obs;
  String token = "";
  @override
  void onInit() {
    super.onInit();
    Get_Todos();
  }
  Future<void> Register_User() async {
    if (regname.text.isEmpty || regpass.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Both username and password are required",
        backgroundColor: Colors.red,
          icon: Icon(Icons.error),
          dismissDirection: DismissDirection.horizontal
      );
      return;
    }
    var dat = {
      "username": regname.text,
      "password": regpass.text
    };
    var url = Uri.parse("https://middle-tasks.vercel.app/register");
    var res = await http.post(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode(dat)
    );
    if (res.statusCode == 200) {
      Get.snackbar("Success", "User Created Successfully", icon: Icon(Icons.check_circle_outline),
          dismissDirection: DismissDirection.horizontal,backgroundColor: Colors.green.shade500);
      regname.clear();
      regpass.clear();
    } else if (res.statusCode == 400) {
      Get.snackbar("Warning", "User Already Exists", backgroundColor: Colors.red, icon: Icon(Icons.error),
          dismissDirection: DismissDirection.horizontal);
      regname.clear();
      regpass.clear();
    } else {
      Get.snackbar("Error", "Something went wrong", backgroundColor: Colors.red, icon: Icon(Icons.error),
          dismissDirection: DismissDirection.horizontal);
    }
  }
  Future<void> Login_User() async {
    if (loginname.text.isEmpty || loginpass.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Both username and password are required",
        backgroundColor: Colors.red,
        icon: Icon(Icons.error),
        dismissDirection: DismissDirection.horizontal
      );
      return;
    }
    var dat = {
      "username": loginname.text,
      "password": loginpass.text
    };
    var url = Uri.parse("https://middle-tasks.vercel.app/login");
    var res = await http.post(url, headers: {'Content-Type': 'application/json; charset=UTF-8'}, body: json.encode(dat));
    if (res.statusCode == 200) {
      var dat = jsonDecode(res.body);
      token = dat['token'];
      print(token);
      Get_Todos();
      Get.to(() => Todo());
    } else if (res.statusCode == 403) {
      Get.snackbar("Warning", "Password Not Matched", backgroundColor: Colors.red, icon: Icon(Icons.error),
          dismissDirection: DismissDirection.horizontal);
    } else if (res.statusCode == 404) {
      Get.snackbar("Warning", "User Not Found", backgroundColor: Colors.red, icon: Icon(Icons.error),
          dismissDirection: DismissDirection.horizontal);
    }
  }
  Future<void> Get_Todos() async {
    var url = Uri.parse("https://middle-tasks.vercel.app/read_todo");
    var res = await http.get(url, headers: {'Authorization': 'Bearer $token'});
    if (res.statusCode == 200) {
      isLoading.value=false;
      var data = jsonDecode(res.body);
      arr.assignAll(data);
      print(data['task']);
    } else {
      print("Error");
    }
  }
  Future<void> Add_to_todo(BuildContext context) async {
    var dat = {
      "task": todoadd.text,
    };
    var url = Uri.parse("https://middle-tasks.vercel.app/create_todo");
    var res = await http.post(url, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    }, body: json.encode(dat));
    if (res.statusCode == 200) {
      Get.snackbar("Success", "Todo Added Successfully");
      todoadd.clear();
      Get_Todos();
      Navigator.of(context).pop();
    } else {
      Get.snackbar("Error", "Adding Todo Failed");
    }
  }
  Future<void> Delete_from_todo(String idx) async {
    var url = Uri.parse("https://middle-tasks.vercel.app/delete_todo/$idx");
    var res = await http.delete(url, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },);
    if (res.statusCode == 200) {
      Get.snackbar("Success", "Deleted Successfully",dismissDirection: DismissDirection.horizontal,backgroundColor: Colors.green.shade400);
      Get_Todos();
    } else {
      Get.snackbar("Error", "Deleting Failed");
    }
  }
  Future<void> Logout_User() async {
    token = "";
    loginname.clear();
    loginpass.clear();
    isLoading.value=true;
    arr.clear();
    Get.offAll(() => Login(),transition: Transition.cupertino);
  }
}
