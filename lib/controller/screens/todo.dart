import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled4/controller/bosscontroller.dart';
class Todo extends StatelessWidget{
  Bosscontroller controller=Get.find();
  @override
  Widget build(BuildContext context) {
    var mdw=MediaQuery.of(context).size.width;
    var mdh=MediaQuery.of(context).size.height;
    return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: RichText(
              text: TextSpan(
                  style: TextStyle(color: Colors.black,fontSize:mdw*0.058 ),
                  children: [
                    TextSpan(text: "Welcome "),
                    TextSpan(text: "${controller.loginname.text},",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                    TextSpan(text: " 👋")
                  ]
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(onPressed: (){controller.Logout_User();}, icon: Icon(Icons.logout)),
              )
            ],
          ),
          body: Obx((){
            if(controller.isLoading.value){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: mdh*0.05,),
                    Text("Please Wait",style: TextStyle(fontSize: mdw*0.05),)
                  ],
                ),
              );
            }
            else if(controller.arr.isEmpty)
              {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("No Task!",style: TextStyle(fontSize: mdw*0.08),)
                    ],
                  ),
                );
              }
            else{
              return ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      trailing: IconButton(onPressed: (){controller.Delete_from_todo(controller.arr[index]['_id']);}, icon: Icon(Icons.delete)),
                      title: Text("${controller.arr[index]['task']}",style: TextStyle(fontSize: mdw*0.05,fontWeight: FontWeight.bold),),);
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: controller.arr.length);
            }
          }),
          floatingActionButton: FloatingActionButton(onPressed: (){
            showDialog<void>(
                context: context,
                builder: (BuildContext dialogContext) {
                  return AlertDialog(
                    title: Text('Add Todo'),
                    content: Container(
                      child: TextField(
                        controller: controller.todoadd,
                        decoration: InputDecoration(
                          hintText: "Enter Todo"
                        ),
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text('add Todo'),
                        onPressed: () {
                          controller.Add_to_todo(context);
                        },
                      ),
                      TextButton(
                        child: Text('close'),
                        onPressed: () {
                          Navigator.of(dialogContext)
                              .pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },child: Icon(Icons.add),),
        );
  }
}