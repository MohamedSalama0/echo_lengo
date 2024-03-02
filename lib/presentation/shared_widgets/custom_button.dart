import 'package:flutter/material.dart';
import 'package:learning_letters_easy/utils/app_style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.onTap,
      this.icon,
      required this.text,
      this.height,
      this.width});
  final VoidCallback onTap;
  final IconData? icon;
  final String text;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? sizedW(context) * 0.55,
      height: height ?? sizedH(context) * 0.17,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Column(
            mainAxisAlignment: icon == null
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceAround,
            children: [
              icon == null
                  ? const SizedBox.shrink()
                  : Icon(
                      icon,
                      size: 50,
                    ),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
