import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../api_connection/api_connection.dart';
import 'package:http/http.dart' as http;
import '../model/user.dart';
import '../user_pref.dart';
import '../widgets/form_field.dart';
import '../widgets/main_button.dart';
import 'Homescreen.dart';




class LoginScreen extends StatefulWidget {
   LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  // var isObsecure = true.obs;
   loginUserNow() async
   {
     try
     {
       var res = await http.post(
         Uri.parse(API.login),
         body: {
           "user_email": emailController.text.trim(),
           "user_password": passwordController.text.trim(),
         },
       );

       if(res.statusCode == 200) //from flutter app the connection with api to server - success
           {
         var resBodyOfLogin = jsonDecode(res.body);
         if(resBodyOfLogin['success'] == true)
         {
           Fluttertoast.showToast(msg: "you are logged-in Successfully.");

            User userInfo = User.fromJson(resBodyOfLogin["userData"]);

           //save userInfo to local Storage using Shared Prefrences
           await RememberUserPrefs.storeUserInfo(userInfo);

           Future.delayed(Duration(milliseconds: 2000), ()
           {
             Get.to(HomeScreen());
           });
         }
         else
         {
           Fluttertoast.showToast(msg: "Incorrect Credentials.\nPlease write correct password or email and Try Again.");
         }
       }
       else
       {
         Fluttertoast.showToast(msg: "Status is not 200");
       }
     }
     catch(errorMsg)
     {
       print("Error :: " + errorMsg.toString());
     }
   }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         const Padding(
           padding: EdgeInsets.all(35.0),
           child: Text("Login",style: TextStyle(fontSize: 35),),
         ),
          Padding(
            padding: EdgeInsets.only(left: 40,right: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text('Email',style: TextStyle(fontSize: 15),),
                SizedBox(height: 5,),
                CustomTextField(
                  controller: emailController,
                  validator: (val) => val == "" ? "Please write email" : null,
                  // decoration: InputDecoration(
                  //   prefixIcon: const Icon(
                  //     Icons.email,
                  //     color: Colors.black,
                  //   ),
                  //   hintText: "email...",
                  //   border: OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(30),
                  //     borderSide: const BorderSide(
                  //       color: Colors.white60,
                  //     ),
                  //   ),
                  //   enabledBorder: OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(30),
                  //     borderSide: const BorderSide(
                  //       color: Colors.white60,
                  //     ),
                  //   ),
                  //   focusedBorder: OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(30),
                  //     borderSide: const BorderSide(
                  //       color: Colors.white60,
                  //     ),
                  //   ),
                  //   disabledBorder: OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(30),
                  //     borderSide: const BorderSide(
                  //       color: Colors.white60,
                  //     ),
                  //   ),
                  //   contentPadding: const EdgeInsets.symmetric(
                  //     horizontal: 14,
                  //     vertical: 6,
                  //   ),
                  //   fillColor: Colors.white,
                  //   filled: true,
                  // ),
                  hintText: 'Enter Your Email',
                ),
              ],
            ),
          ),
          const SizedBox(height: 15,),
          Padding(
            padding: EdgeInsets.only(left: 40,right: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text('Password',style: TextStyle(fontSize: 15),),
                SizedBox(height: 5,),
                CustomTextField(
                  controller: passwordController,
                  validator: (val) => val == "" ? "Please write Password" : null,
                  hintText: 'Enter Your Password',
                ),
              ],
            ),
          ),
          const SizedBox(height: 30,),
          Center(
            child: MainButton(
              title: 'Sign In',

              onPressed: (){
                loginUserNow();
                  },

              isEnabled: true,



              ),



            ),







        ],

      ),
    );
  }
}
