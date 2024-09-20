import 'package:flutter/material.dart';
import 'package:untitled4/controller/bosscontroller.dart';
import 'package:get/get.dart';
import 'package:untitled4/controller/screens/login.dart';
class Registration extends StatelessWidget{
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
                Text("REGISTER",style: TextStyle(fontSize: mdh*0.067,fontWeight: FontWeight.w800),),
                TextField(
                  controller:controller.regname ,
                  decoration: InputDecoration(
                      hintText: "New Username"
                  ),
                ),
                SizedBox(height: mdh*0.02,),
                TextField(
                  controller: controller.regpass,
                  decoration: InputDecoration(
                      hintText: "New Password"
                  ),
                ),
                SizedBox(height: mdh*0.02,),
                ElevatedButton(onPressed: (){controller.Register_User();}, child: Text("REGISTER NOW")),
                SizedBox(height: mdh*0.02,),
                GestureDetector(
                  onTap: (){Get.to(()=>Login(),transition: Transition.cupertino);},
                  child: RichText(text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children:[
                        TextSpan(text: "Already Have Account?"),
                        TextSpan(text: "  "),
                        TextSpan(text: "Login Now",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold))
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