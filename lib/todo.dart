import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list_task/screens/Homescreen.dart';
import 'package:todo_list_task/screens/login_screen.dart';
import 'package:todo_list_task/user_pref.dart';


class Todo extends StatelessWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:  FutureBuilder(
        future: RememberUserPrefs.readUserInfo(),
        builder: (context, dataSnapShot)
        {
          if(dataSnapShot.data == null)
          {
            return LoginScreen();
          }
          else
          {
            return HomeScreen();
          }
        },
      ),

    );
  }
}