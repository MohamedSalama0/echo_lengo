import 'package:flutter/material.dart';
import 'package:learning_letters_easy/presentation/screens/content/view/content_screen.dart';
import 'package:learning_letters_easy/presentation/screens/questions/view/questions_screen.dart';
import 'package:learning_letters_easy/presentation/shared_widgets/custom_button.dart';
import 'package:learning_letters_easy/utils/app_style.dart';

class AlphabetOptionsScreen extends StatelessWidget {
  const AlphabetOptionsScreen({super.key, required this.isEnglish});
  final bool isEnglish;

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
                    builder: (context) =>  ContentScreen(isEnglish: isEnglish),
                  ),
                );
              },
              text: 'الحروف',
            ),
            SizedBox(height: sizedH(context) * 0.04),
            CustomButton(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  QuestionsScreen(isEnglish: isEnglish),
                  ),
                );

              },
              text: 'الأسئلة',
            ),
          ],
        ),
      ),
    );
  }
}
