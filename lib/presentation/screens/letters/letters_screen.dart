import 'package:flutter/material.dart';
import 'package:learning_letters_easy/presentation/screens/content/view/content_screen.dart';
import 'package:learning_letters_easy/presentation/shared_widgets/custom_button.dart';
import 'package:learning_letters_easy/presentation/shared_widgets/static_letters.dart';
import 'package:learning_letters_easy/utils/app_style.dart';

class LettersScreen extends StatelessWidget {
  final bool isEnglish;
  const LettersScreen({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    List<String> letters = isEnglish ? lettersEnglish : lettersArabic;
    if (!isEnglish) {
      // Reverse the order for Arabic letters
      letters = letters.reversed.toList();
    }
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    mainAxisExtent: 100,
                  ),
                  reverse: isEnglish? false: true,
                  itemCount:
                      isEnglish ? lettersEnglish.length : lettersArabic.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: CustomButton(
                        onTap: () {
                          int correctIndex =
                              isEnglish ? index : letters.length - 1 - index;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ContentScreen(
                                    isEnglish: isEnglish, index: correctIndex),
                              ));
                        },
                        // height: sizedH(context) * 0.12,
                        // width: sizedW(context) * 0.12,
                        text: letters[index],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
