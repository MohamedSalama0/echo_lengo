import 'package:flutter/material.dart';
import 'package:learning_letters_easy/presentation/shared_widgets/custom_button.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        physics: const BouncingScrollPhysics(),
        crossAxisCount: 2,
        shrinkWrap: true,
        crossAxisSpacing: 20,
        semanticChildCount: 2,
        mainAxisSpacing: 20,
        children: [
          CustomButton(
            onTap: () {},
            text: 'About Us',
          ),
          CustomButton(
            onTap: () {},
            text: 'About Us',
          ),
        ],
      ),
    );
  }
}
