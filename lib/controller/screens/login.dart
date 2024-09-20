import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled4/controller/bosscontroller.dart';
import 'package:untitled4/controller/screens/registration.dart';
class Login extends StatelessWidget{
  Bosscontroller controller=Get.find();
  @override
  Widget build(BuildContext context) {
    var mdw=MediaQuery.of(context).size.width;
    var mdh=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(30),
            child: Column(
              children: [
                Text("LOGIN",style: TextStyle(fontSize: mdh*0.067,fontWeight: FontWeight.w800),),
                TextField(
                  controller: controller.loginname,
                  decoration: InputDecoration(
                    hintText: "Username"
                  ),
                ),
                SizedBox(height: mdh*0.02,),
                TextField(
                  controller: controller.loginpass,
                  decoration: InputDecoration(
                    hintText: "Password"
                  ),
                ),
                SizedBox(height: mdh*0.02,),
                ElevatedButton(onPressed: (){controller.Login_User();}, child: Text("LOGIN")),
                SizedBox(height: mdh*0.02,),
                GestureDetector(
                  onTap: (){Get.to(()=>Registration(),transition: Transition.cupertino);},
                  child: RichText(text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children:[
                      TextSpan(text: "Dont Have Account?"),
                      TextSpan(text: "  "),
                      TextSpan(text: "Register Now",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold))
                    ]
                  ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}