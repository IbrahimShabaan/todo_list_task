// import 'package:flutter/material.dart';
// final navKey = GlobalKey<NavigatorState>();
// final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
// class AppButtons {
//   static Widget customTextButton({
//     required String text,
//     double? fontSize = 12,
//     Color color = Colors.orange,
//     Color? hoverColor,
//     double width = 40,
//     double height = 49,
//     required void Function()? onPressed,
//     EdgeInsetsGeometry? padding,
//     TextDecoration? decoration,
//   }) =>
//       TextButton(
//         style: TextButton.styleFrom(
//           foregroundColor: hoverColor,
//           minimumSize: Size(width, height),
//           padding: padding,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//         child: Text(
//           text,
//           style: TextStyle(
//             fontSize: fontSize,
//             color: color,
//             decoration: decoration,
//           ),
//         ),
//         onPressed: onPressed,
//       );
//
//   static Widget customButtonBack(
//       context,
//       ) =>
//       IconButton(
//         icon: Icon(Icons.arrow_back_ios_new, size: 20),
//         onPressed: () => Navigator.pop(context),
//       );
// }
//
//
// void goTo(context, widget) =>
//     Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
//
// void goToAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
//     context, MaterialPageRoute(builder: (context) => widget), (route) => false);
//
// void goAndFinish(widget) => navKey.currentState!.pushAndRemoveUntil(
//     MaterialPageRoute(builder: (context) => widget), (route) => false);
