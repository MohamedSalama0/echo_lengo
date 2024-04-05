import 'package:flutter/material.dart';
import 'package:learning_letters_easy/presentation/screens/exams/exams_screen.dart';
import 'package:learning_letters_easy/presentation/screens/letters/letters_screen.dart';
import 'package:learning_letters_easy/presentation/screens/questions/view/questions_screen.dart';
import 'package:learning_letters_easy/presentation/shared_widgets/custom_button.dart';
import 'package:learning_letters_easy/utils/app_style.dart';

class ChooseQuestionsOrExamsScreen extends StatelessWidget {
  final bool comingFormContentScreen;
  final bool isEnglish;
  const ChooseQuestionsOrExamsScreen(
      {super.key,
      required this.comingFormContentScreen,
      required this.isEnglish});

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
                      builder: (context) =>
                           QuestionsScreen(isEnglish: isEnglish)),
                );
              },
              text: 'الأسئلة',
            ),
            SizedBox(height: sizedH(context) * 0.04),
            CustomButton(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExamsScreen(isEnglish: isEnglish),
                  ),
                );
              },
              text: 'المراجعة',
            ),
          ],
        ),
      ),
    );
  }
}
