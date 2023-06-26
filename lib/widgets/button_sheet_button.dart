// import 'package:flutter/material.dart';
// import 'package:todo_list_task/core/utils/media_query_values.dart';
//
// class ButtonSheetButton extends StatelessWidget {
//   const ButtonSheetButton({
//     Key? key,
//     this.icon,
//     this.iconColor,
//     required this.text,
//     required this.textColor,
//     required this.onPressed,
//   }) : super(key: key);
//
//   final String text;
//   final IconData? icon;
//   final Color? iconColor;
//   final Color? textColor;
//   final void Function()? onPressed;
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: context.width / 1.6,
//       child: NeumorphicButton(
//         style: const NeumorphicStyle(
//           depth: 4,
//           intensity: 4,
//           boxShape: NeumorphicBoxShape.stadium(),
//         ),
//         minDistance: -4,
//         onPressed: onPressed,
//         child: Wrap(
//           crossAxisAlignment: WrapCrossAlignment.center,
//           alignment: WrapAlignment.center,
//           children: [
//             Icon(icon, color: iconColor),
//             SizedBox(width: context.width / 30),
//             Text(
//               text,
//               style: TextStyle(
//                 fontSize: 20,
//                 color: textColor,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
