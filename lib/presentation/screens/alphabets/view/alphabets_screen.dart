import 'package:flutter/material.dart';
import 'package:learning_letters_easy/presentation/screens/alphabet_details/view/alphabet_options_screen.dart';
import 'package:learning_letters_easy/presentation/shared_widgets/custom_button.dart';
import 'package:learning_letters_easy/utils/app_style.dart';

class AlphabetsScreen extends StatelessWidget {
  const AlphabetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomButton(
              onTap: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AlphabetOptionsScreen(isEnglish: false),
                  ),
                );
              },
              text: 'اللغة العربية',
            ),
            SizedBox(height: sizedH(context) * 0.04),
            CustomButton(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AlphabetOptionsScreen(isEnglish: true),
                  ),
                );
              },
              text: 'English',
            ),
          ],
        ),
      ),
    );
  }
}
