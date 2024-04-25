import 'package:flutter/material.dart';
import 'package:learning_letters_easy/utils/app_colors.dart';
import 'package:learning_letters_easy/utils/app_style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
    this.buttonColor,
    this.iconWidth,
    this.style,
    this.iconData,
    this.textColor,
  });

  final Function onTap;
  final String text;
  final IconData? iconData;
  final TextStyle? style;
  final Color? buttonColor;
  final Color? textColor;
  final double? iconWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      // 070
      height: sizedH(context) * 0.060,
      // 88
      width: sizedW(context) * 0.87,
      decoration: BoxDecoration(
        color: buttonColor ?? kWhite,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextButton(
        onPressed: () {
          onTap();
        },
        child: iconData == null
            ? Text(
                text,
                style: style ??
                    TextStyle(
                      color: textColor ?? kBlack,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    iconData!,
                    size: iconWidth,
                  ),
                  SizedBox(width: sizedW(context) * 0.05),
                  Text(
                    text,
                    style: style ??
                        TextStyle(color: textColor ?? kBlack, fontSize: 16),
                  ),
                ],
              ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:learning_letters_easy/utils/app_style.dart';

// class CustomButton extends StatelessWidget {
//   const CustomButton(
//       {super.key,
//       required this.onTap,
//       this.icon,
//       required this.text,
//       this.height,
//       this.width,
//       this.fontSize = 20});
//   final VoidCallback onTap;
//   final IconData? icon;
//   final String text;
//   final double fontSize;
//   final double? height;
//   final double? width;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: width ?? sizedW(context) * 0.55,
//       height: height ?? sizedH(context) * 0.17,
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.grey[200],
//         borderRadius: BorderRadius.circular(18),
//       ),
//       child: InkWell(
//         onTap: onTap,
//         child: Center(
//           child: Column(
//             mainAxisAlignment: icon == null
//                 ? MainAxisAlignment.center
//                 : MainAxisAlignment.spaceAround,
//             children: [
//               icon == null
//                   ? const SizedBox.shrink()
//                   : Icon(
//                       icon,
//                       size: 50,
//                     ),
//               Flexible(
//                 child: Text(
//                   text,
//                   maxLines: 2,
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: fontSize,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
