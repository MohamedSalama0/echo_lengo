import 'package:flutter/material.dart';
import 'package:learning_letters_easy/presentation/screens/choose%20questions%20or%20exams/choose_questions_or_exams.dart';
import 'package:learning_letters_easy/presentation/screens/exams/exams_screen.dart';
import 'package:learning_letters_easy/presentation/screens/letters/letters_screen.dart';
import 'package:learning_letters_easy/presentation/shared_widgets/custom_button.dart';
import 'package:learning_letters_easy/utils/app_style.dart';

class ChooseLanguageScreen extends StatelessWidget {
  final bool comingFormContentScreen;
  const ChooseLanguageScreen(
      {super.key, required this.comingFormContentScreen});

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
                    builder: (context) => comingFormContentScreen
                        ? const LettersScreen(isEnglish: false)
                        : ChooseQuestionsOrExamsScreen(
                            comingFormContentScreen: comingFormContentScreen,
                            isEnglish: false),
                  ),
                );
              },
              text: 'اللغة العربية',
            ),
            SizedBox(height: sizedH(context) * 0.04),
            CustomButton(
              onTap: () {
                MaterialPageRoute(
                  builder: (context) => comingFormContentScreen
                      ? const LettersScreen(isEnglish: false)
                      : ChooseQuestionsOrExamsScreen(
                          comingFormContentScreen: comingFormContentScreen,
                          isEnglish: false),
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
