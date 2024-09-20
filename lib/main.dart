import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled4/controller/bosscontroller.dart';
import 'package:untitled4/controller/screens/login.dart';
void main()
{
  Get.put(Bosscontroller());
  runApp(Main());
}
class Main extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.white30,
          filled: true,
          outlineBorder: BorderSide.none,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25)
          ),
          hintStyle: TextStyle(fontWeight: FontWeight.w800,color: Colors.black),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.blue),
            foregroundColor: WidgetStateProperty.all(Colors.white)
          )
        )
      ),
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}