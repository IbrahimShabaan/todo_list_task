import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import '../api_connection/api_connection.dart';
import '../core/utils/app_colors.dart';
import '../model/note.dart';
import '../user_pref.dart';
import 'edit_screen.dart';
import 'login_screen.dart';
import 'package:http/http.dart' as http;


class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);

   final List<Color> colors = [
     Colors.deepOrange.shade200,
     Colors.cyan.shade200,
     Colors.green.shade200,
     Colors.blue.shade200,
     Colors.purple.shade200,
   ];

  final TextEditingController noteController = TextEditingController();

  final TextEditingController dateController = TextEditingController();
   final TextEditingController nameController = TextEditingController();
   final TextEditingController endTimeController = TextEditingController();
   final TextEditingController startTimeController = TextEditingController();
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

   signOutUser() async
   {
     var resultResponse = await Get.dialog(
       AlertDialog(
         backgroundColor: Colors.grey,
         title: const Text(
           "Logout",
           style: TextStyle(
             fontSize: 18,
             fontWeight: FontWeight.bold,
           ),
         ),
         content: const Text(
           "Are you sure?\nyou want to logout from app?",
         ),
         actions: [
           TextButton(
               onPressed: ()
               {
                 Get.back();
               },
               child: const Text(
                 "No",
                 style: TextStyle(
                   color: Colors.black,
                 ),
               )
           ),
           TextButton(
               onPressed: ()
               {
                 Get.back(result: "loggedOut");
               },
               child: const Text(
                 "Yes",
                 style: TextStyle(
                   color: Colors.black,
                 ),
               )
           ),
         ],
       ),
     );

     if(resultResponse == "loggedOut")
     {
       //delete-remove the user data from phone local storage
       RememberUserPrefs.removeUserInfo()
           .then((value)
       {
         Get.off(LoginScreen());
       });
     }
   }

   Future<List<Notes>> getAllNotes() async
   {
     List<Notes> allNotesList = [];
     try
     {
       var res = await http.post(
           Uri.parse(API.getAllNotes)
       );

       if(res.statusCode == 200)
       {
         var responseBodyOfAllClothes = jsonDecode(res.body);
         if(responseBodyOfAllClothes["success"] == true)
         {
           (responseBodyOfAllClothes["noteData"] as List).forEach((eachRecord)
           {
             allNotesList.add(Notes.fromJson(eachRecord));
           });
         }
       }
       else
       {
         Fluttertoast.showToast(msg: "Error, status code is not 200");
       }
     }
     catch(errorMsg)
     {
       print("Error:: " + errorMsg.toString());
     }

     return allNotesList;
   }

   editNoteToDatabase() async
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
         },
       );

       if(response.statusCode == 200)
       {
         var resBodyOfUploadItem = jsonDecode(response.body);

         if(resBodyOfUploadItem['success'] == true)
         {
           Fluttertoast.showToast(msg: "New Note uploaded successfully");



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



   deleteNote (int noteID) async
   {
     try
     {
       var res = await http.post(
           Uri.parse(API.deleteNote),
           body:
           {
             "note_id": noteID.toString(),
           }
       );

       if(res.statusCode == 200)
       {
         var responseBodyFromDeleteNote = jsonDecode(res.body);

         if(responseBodyFromDeleteNote["success"] == true)
         {
           Get.to(HomeScreen());

         }
       }
       else
       {
         Fluttertoast.showToast(msg: "Error, Status Code is not 200");
       }
     }
     catch(errorMessage)
     {
       print("Error: " + errorMessage.toString());

       Fluttertoast.showToast(msg: "Error: " + errorMessage.toString());
     }
   }




   @override
  Widget build(BuildContext context) {

     return  Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.grediantcolor1,
              AppColors.grediantcolor2,
              AppColors.grediantcolor3,
            ]

        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,

        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    AppColors.grediantcolor1,
                    AppColors.grediantcolor2,
                    AppColors.grediantcolor3,
                  ]

              ),
            ),
          ),

          actions: [
            IconButton(
              icon: Icon(Icons.logout,color: Colors.red,), onPressed: () {
              signOutUser();

            },
            ),
          ],


          iconTheme: const IconThemeData(
            color: Colors.redAccent,
          ),
          elevation: 0,
          centerTitle: true,
          title: const Text('TODO',style: TextStyle(color: Colors.black,),),
        ),
        drawer:   Drawer(
          // child: Container(
          //
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //         colors: [
          //           AppColors.grediantcolor1,
          //           AppColors.grediantcolor2,
          //           AppColors.grediantcolor3,
          //         ]
          //
          //     ),
          //   ),
          //
          //   child:  Padding(
          //     padding: const EdgeInsets.only(top: 50,left: 25),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         const Text('New Task',style: TextStyle(color: Colors.black,fontSize: 25),),
          //         const SizedBox(height: 35,),
          //         const Text('Color',style: TextStyle(color: Colors.grey,fontSize: 15),),
          //         const SizedBox(height: 15,),
          //
          //         const Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceAround,
          //           children: [
          //             CircleAvatar(
          //               backgroundColor: Colors.pink,
          //               radius: 15,
          //             ),
          //             CircleAvatar(
          //               backgroundColor: Colors.blue,
          //               radius: 15,
          //             ),
          //             CircleAvatar(
          //               backgroundColor: Colors.purple,
          //               radius: 15,
          //             ),
          //             CircleAvatar(
          //               backgroundColor: Colors.black87,
          //               radius: 15,
          //             ),
          //             CircleAvatar(
          //               backgroundColor: Colors.green,
          //               radius: 15,
          //             ),
          //             CircleAvatar(
          //               backgroundColor: Colors.yellow,
          //               radius: 15,
          //             ),
          //           ],
          //         ),
          //         const SizedBox(height: 15,),
          //         const Text('Name',style: TextStyle(color: Colors.grey,fontSize: 15),),
          //         const SizedBox(height: 15,),
          //         SizedBox(
          //           width: 250,
          //           child:  TextField(
          //             controller: nameController,
          //
          //             decoration: const InputDecoration(
          //               enabledBorder: UnderlineInputBorder(
          //                 borderSide: BorderSide(color: Colors.pink),
          //               ),
          //               focusedBorder: UnderlineInputBorder(
          //                 borderSide: BorderSide(color: Colors.pink),
          //               ),
          //
          //             ),
          //
          //           ),
          //         ),
          //         const SizedBox(height: 15,),
          //         const Text('Description',style: TextStyle(color: Colors.grey,fontSize: 15),),
          //         const SizedBox(height: 15,),
          //         Padding(
          //           padding: const EdgeInsets.only(right: 5),
          //           child: CustomFormField(hintText: 'Description',
          //             controller: noteController,
          //           ),
          //         ),
          //         const SizedBox(height: 25,),
          //         const Text('Date',style: TextStyle(color: Colors.grey,fontSize: 15),),
          //         TextField(
          //           controller: dateController,
          //           onTap: ()=> customShowDatePicker(context),
          //         ),
          //
          //         const SizedBox(height: 25,),
          //         const Text('Time',style: TextStyle(color: Colors.grey,fontSize: 15),),
          //         TextField(
          //           controller: startTimeController,
          //           // validator: (value) {
          //           //   if (value!.isEmpty) {
          //           //     return 'Field is require';
          //           //   }
          //           //   return null;
          //           // },
          //           onTap: () async {
          //             await showTimePicker(
          //               context: context,
          //               initialTime: TimeOfDay.now(),
          //             ).then((value) {
          //               value != null
          //                   ? startTimeController.text =
          //                   value.format(context)
          //                   : null;
          //             });
          //           },
          //
          //         ),
          //        SizedBox(height: 15,),
          //
          //        Row(
          //          mainAxisAlignment: MainAxisAlignment.spaceAround,
          //          children: [
          //            ElevatedButton(
          //              onPressed: (){},
          //              child: Text('Delete'),
          //              style: ElevatedButton.styleFrom(
          //                elevation: 2,
          //                 minimumSize: Size(100, 47),
          //                textStyle: TextStyle(fontSize: 12),
          //                backgroundColor: Colors.red,
          //                padding: const EdgeInsets.symmetric(horizontal: 16),
          //                shape: const RoundedRectangleBorder(
          //                  borderRadius: BorderRadius.all(Radius.circular(22)),
          //                ),
          //              ),
          //
          //
          //
          //
          //            ),
          //
          //            ElevatedButton(
          //              onPressed: (){},
          //              child: Text('Update'),
          //              style: ElevatedButton.styleFrom(
          //                elevation: 2,
          //                minimumSize: Size(100, 47),
          //                textStyle: TextStyle(fontSize: 12),
          //                backgroundColor: Colors.lightBlueAccent,
          //                padding: const EdgeInsets.symmetric(horizontal: 16),
          //                shape: const RoundedRectangleBorder(
          //                  borderRadius: BorderRadius.all(Radius.circular(22)),
          //                ),
          //              ),
          //
          //
          //
          //
          //            ),
          //
          //          ],
          //        ),
          //
          //
          //
          //
          //
          //
          //
          //
          //       ],
          //     ),
          //   ),
          // ),
        ),
        body: FutureBuilder(
            future: getAllNotes(),
            builder: (context, AsyncSnapshot<List<Notes>> dataSnapShot)
            {
              if(dataSnapShot.connectionState == ConnectionState.waiting)
              {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if(dataSnapShot.data == null)
              {
                return const Center(
                  child: Text(
                    "No Note found",
                  ),
                );
              }
              if(dataSnapShot.data!.length > 0)
              {
                return ListView.builder(
                  itemCount: dataSnapShot.data!.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index)
                  {
                    Notes eachNotes = dataSnapShot.data![index];
                    return InkWell(
                      onTap: () =>showDialog(
                          context: context,
                          builder: (context)=> SingleChildScrollView(
                            child: AlertDialog(

                              backgroundColor: Colors.transparent,
                              content: Container(

                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        AppColors.grediantcolor1,
                                        AppColors.grediantcolor2,
                                        AppColors.grediantcolor3,
                                      ]

                                  ),
                                ),

                                child:  Padding(
                                  padding: const EdgeInsets.only(top: 50,left: 25),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('Edit Task',style: TextStyle(color: Colors.black,fontSize: 25),),
                                      const SizedBox(height: 35,),
                                      const Text('Color',style: TextStyle(color: Colors.grey,fontSize: 15),),
                                      const SizedBox(height: 15,),

                                      const Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Colors.pink,
                                            radius: 15,
                                          ),
                                          CircleAvatar(
                                            backgroundColor: Colors.blue,
                                            radius: 15,
                                          ),
                                          CircleAvatar(
                                            backgroundColor: Colors.purple,
                                            radius: 15,
                                          ),
                                          CircleAvatar(
                                            backgroundColor: Colors.black87,
                                            radius: 15,
                                          ),
                                          CircleAvatar(
                                            backgroundColor: Colors.green,
                                            radius: 15,
                                          ),
                                          CircleAvatar(
                                            backgroundColor: Colors.yellow,
                                            radius: 15,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 15,),
                                       Text('Note Name',style: TextStyle(color: Colors.grey,fontSize: 15),),
                                      const SizedBox(height: 15,),
                                      TextFormField(
                                        initialValue: eachNotes.note_name!,
                                      ),
                                      const SizedBox(height: 15,),
                                      const Text('Description',style: TextStyle(color: Colors.grey,fontSize: 15),),
                                      TextFormField(
                                        initialValue: eachNotes.note_description!,
                                      ),
                                      const SizedBox(height: 15,),

                                      const SizedBox(height: 25,),
                                      const Text('Date',style: TextStyle(color: Colors.grey,fontSize: 15),),
                                      TextField(
                                        controller: dateController,
                                        onTap: ()=> customShowDatePicker(context),

                                      ),

                                      const SizedBox(height: 25,),
                                      const Text('Time',style: TextStyle(color: Colors.grey,fontSize: 15),),
                                      TextField(
                                        controller: startTimeController,
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
                                                ? startTimeController.text =
                                                value.format(context)
                                                : null;
                                          });
                                        },

                                      ),
                                      SizedBox(height: 15,),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          ElevatedButton(
                                            onPressed: ()  {
                                              deleteNote(eachNotes.note_id!);
                                            },
                                            child: Text('Delete'),
                                            style: ElevatedButton.styleFrom(
                                              elevation: 2,
                                              minimumSize: Size(100, 47),
                                              textStyle: TextStyle(fontSize: 12),
                                              backgroundColor: Colors.red,
                                              padding: const EdgeInsets.symmetric(horizontal: 16),
                                              shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(22)),
                                              ),
                                            ),




                                          ),

                                          ElevatedButton(
                                            onPressed: (){
                                              editNoteToDatabase();
                                            },
                                            child: Text('Update'),
                                            style: ElevatedButton.styleFrom(
                                              elevation: 2,
                                              minimumSize: Size(100, 47),
                                              textStyle: TextStyle(fontSize: 12),
                                              backgroundColor: Colors.lightBlueAccent,
                                              padding: const EdgeInsets.symmetric(horizontal: 16),
                                              shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(22)),
                                              ),
                                            ),




                                          ),

                                        ],
                                      ),








                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                      ),
                      child: Column(


                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30,top:10,right: 30),
                            child: Container(

                              color: Colors.white,
                              child: ListTile(

                                leading:CircleAvatar(
                                  backgroundColor: Colors.red,
                                  radius: 15,
                                ),

                                title: Text(eachNotes.note_description!),
                                trailing:Column(
                                  children: [
                                    Text('Date'),
                                    SizedBox(width: 5,),
                                    Text(eachNotes.time!,style: TextStyle(color: Colors.grey),),
                                  ],
                                ),

                              ),
                            ),
                          ),
                         



                        ],


                      ),
                    );
                  },
                );



              }
              else
              {
                return const Center(
                  child: Text("Empty, No Data."),
                );
              }
            },),







        floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.white,
          backgroundColor:const Color.fromRGBO(74, 157, 237,100),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder:(context) => EditScreen(),
            maintainState: true));
          },
          child: const Icon(Icons.add),
        ),

      ),
    );
  }
}



