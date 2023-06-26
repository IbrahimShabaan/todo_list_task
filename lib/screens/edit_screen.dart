import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../api_connection/api_connection.dart';
import '../core/utils/app_colors.dart';
import '../widgets/custom_form_field.dart';
import 'Homescreen.dart';

class EditScreen extends StatefulWidget {
   EditScreen({Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final TextEditingController noteController = TextEditingController();

  final TextEditingController dateController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController timeController = TextEditingController();


  final List<Color> colors = [
    Colors.deepOrange.shade200,
    Colors.cyan.shade200,
    Colors.green.shade200,
    Colors.blue.shade200,
    Colors.purple.shade200,
  ];
  int selectedColor = 0;

  void changeColor(int index) {

    selectedColor = index;
  }

  void customShowDatePicker(BuildContext context) async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 10),
    ).then((value) {
      value != null
          ? dateController.text = DateFormat.yMMMMd().format(value)
          : null;
    });
  }

   AddNoteToDatabase() async
   {


     try
     {
       var response = await http.post(
         Uri.parse(API.uploadNewNote),
         body:
         {
           'note_id': '1',
           'note_name': nameController.text.trim().toString(),
           'note_description': noteController.text.trim().toString(),
           'date':dateController.text,
           'time':timeController.text,
         },
       );

       if(response.statusCode == 200)
       {
         var resBodyOfUploadItem = jsonDecode(response.body);

         if(resBodyOfUploadItem['success'] == true)
         {
           Fluttertoast.showToast(msg: "New Note uploaded successfully");

           setState(() {
             nameController.clear();
             noteController.clear();
           });

           Get.to(HomeScreen());
         }
         else
         {
           Fluttertoast.showToast(msg: "Note not uploaded. Error, Try Again.");
         }
       }
       else
       {
         Fluttertoast.showToast(msg: "Status is not 200");
       }
     }
     catch(errorMsg)
     {
       print("Error:: " + errorMsg.toString());
     }
   }

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              AppColors.grediantcolor1,
              AppColors.grediantcolor2,
              AppColors.grediantcolor3,
            ]

        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.only(top: 50,left: 25),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('New Task',style: TextStyle(color: Colors.black,fontSize: 25),),
                const SizedBox(height: 35,),
                const Text('Color',style: TextStyle(color: Colors.grey,fontSize: 15),),
                const SizedBox(height: 15,),

                Wrap(
                  alignment: WrapAlignment.center,
                  children:
                  List<Widget>.generate(colors.length, (index) {
                    return InkWell(
                      onTap: () => changeColor(index),
                      child: Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 4.0),
                        child: CircleAvatar(
                          radius: context.height / 65,
                          backgroundColor: colors[index],
                          child: selectedColor == index
                              ? const Icon(Icons.done,
                              color: Colors.white)
                              : null,
                        ),
                      ),
                    );
                  }),
                ),

                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     CircleAvatar(
                //       backgroundColor: Colors.pink,
                //       radius: 15,
                //     ),
                //     CircleAvatar(
                //       backgroundColor: Colors.blue,
                //       radius: 15,
                //     ),
                //     CircleAvatar(
                //       backgroundColor: Colors.purple,
                //       radius: 15,
                //     ),
                //     CircleAvatar(
                //       backgroundColor: Colors.black87,
                //       radius: 15,
                //     ),
                //     CircleAvatar(
                //       backgroundColor: Colors.green,
                //       radius: 15,
                //     ),
                //     CircleAvatar(
                //       backgroundColor: Colors.yellow,
                //       radius: 15,
                //     ),
                //   ],
                // ),
                const SizedBox(height: 15,),
                const Text('Name',style: TextStyle(color: Colors.grey,fontSize: 15),),
                const SizedBox(height: 15,),
                SizedBox(
                  width: 250,
                  child:  TextField(
                    controller: nameController,

                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.pink),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.pink),
                      ),

                    ),

                  ),
                ),
                const SizedBox(height: 15,),
                const Text('Description',style: TextStyle(color: Colors.grey,fontSize: 15),),
                const SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: CustomFormField(hintText: 'Description',
                    controller: noteController,
                  ),
                ),
                const SizedBox(height: 25,),
                const Text('Date',style: TextStyle(color: Colors.grey,fontSize: 15),),
                TextField(
                  controller: dateController,
                  onTap: ()=> customShowDatePicker(context),
                ),

                const SizedBox(height: 25,),
                const Text('Time',style: TextStyle(color: Colors.grey,fontSize: 15),),
                TextField(
                  controller: timeController,
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'Field is require';
                  //   }
                  //   return null;
                  // },
                  onTap: () async {
                    await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    ).then((value) {
                      value != null
                          ? timeController.text =
                          value.format(context)
                          : null;
                    });
                  },

                ),
                SizedBox(height: 25,),

                Center(
                  child: ElevatedButton(
                    onPressed: (){
                      Fluttertoast.showToast(msg: "Uploading now...");

                      AddNoteToDatabase();
                    },
                    child: Text('Add'),
                    style: ElevatedButton.styleFrom(
                      elevation: 2,
                      minimumSize: Size(150, 47),
                      textStyle: TextStyle(fontSize: 12),
                      backgroundColor: Colors.lightBlueAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(22)),
                      ),
                    ),




                  ),
                ),









              ],
            ),
          ),
        ),
      ),
    );
  }
}
