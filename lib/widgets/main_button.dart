import 'package:flutter/material.dart';


import '../core/utils/app_colors.dart';

class MainButton extends StatelessWidget {
  final String title;
  final double? width;
  final double? height;
  final bool isEnabled;
  final void Function() onPressed;
   const MainButton({
    Key? key,
    this.width = 250,
    this.height = 47,
    required this.title,
    required this.onPressed,
    required this.isEnabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 47,
      decoration:  BoxDecoration(
        gradient: LinearGradient(
            colors: [
              AppColors.buttontcolor1,
              AppColors.buttontcolor2,
              AppColors.buttontcolor3,
            ]
        ),
      ),
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,

        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          minimumSize: Size(width!, height!),
          textStyle: const TextStyle(fontSize: 15,),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape:  const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(55,),


            ),
          ),

        ),


        child: Text(title),
      ),
    );
  }
}
