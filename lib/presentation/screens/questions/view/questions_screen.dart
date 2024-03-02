import 'dart:math';

import 'package:flutter/material.dart';
import 'package:learning_letters_easy/presentation/screens/content/view/content_screen.dart';
import 'package:learning_letters_easy/presentation/shared_widgets/static_letters.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key, required this.isEnglish});
  final bool isEnglish;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  final PageController _pageController = PageController();
  static const String enVidPath = 'assets/screenshots/en';
  static const String arVidPath = 'assets/screenshots/ar';
  List<String> paths = [];
  Random random = Random();
  int randomNum = 0;

  @override
  void initState() {
    super.initState();
    paths = letters();
    randomNum = widget.isEnglish ? random.nextInt(26) : random.nextInt(28);
  }

  List<String> letters() {
    List<String> paths = [];
    if (widget.isEnglish) {
      for (String letter in lettersEnglish) {
        paths.add('$enVidPath/$letter.png');
      }
    }
    for (int letter = 1; letter <= lettersArabic.length; letter++) {
      paths.add('$arVidPath/ar$letter.png');
    }
    return paths;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            )),
      ),
      body: PageView(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: [
          ...List.generate(
            paths.length,
            (i) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset(paths[i]),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 12,
                    bottom: 25,
                    end: 12,
                  ),
                  child: Align(
                    alignment: widget.isEnglish
                        ? AlignmentDirectional.centerStart
                        : AlignmentDirectional.centerEnd,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RadioButtonWidget(
                            index: i, isEnglish: widget.isEnglish),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class RadioButtonWidget extends StatefulWidget {
  const RadioButtonWidget(
      {super.key, required this.index, required this.isEnglish});
  final int index;
  final bool isEnglish;
  @override
  _RadioButtonWidgetState createState() => _RadioButtonWidgetState();
}

class _RadioButtonWidgetState extends State<RadioButtonWidget> {
  String? correctAnswer;
  String? selectedOption;
  bool submitted = false;

  List<String> options = [];

  @override
  void initState() {
    super.initState();
    generateRandomOptions();
  }

  void generateRandomOptions() {
    if (widget.isEnglish) {
      List<String> alphabet = List.generate(
          26, (index) => String.fromCharCode('A'.codeUnitAt(0) + index));
      alphabet.removeAt(widget.index);
      alphabet.shuffle();

      int correctIndex = Random().nextInt(3);
      alphabet.insert(
          correctIndex, String.fromCharCode('A'.codeUnitAt(0) + widget.index));

      options = alphabet.sublist(0, 3);

      correctAnswer = options[correctIndex];
    } else {
     var alphabetsAr = List<String>.from(lettersArabic);

    alphabetsAr.removeAt(widget.index);
    alphabetsAr.shuffle();
    int correctIndex = Random().nextInt(3);
    alphabetsAr.insert(
        correctIndex, lettersArabic[widget.index]);

    options = alphabetsAr.sublist(0, 3);

    correctAnswer = lettersArabic[widget.index];

    // Shuffle options again to ensure the correct answer is randomly placed
    options.shuffle();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'Select the correct answer:',
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
        const SizedBox(height: 20.0),
        Column(
          children: options.map((option) {
            return Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: RadioListTile(
                title: Row(
                  children: [
                    Text(
                      '$option ',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(width: 20),
                    if (submitted && option == selectedOption)
                      Icon(
                        option == correctAnswer ? Icons.check : Icons.close,
                        color:
                            option == correctAnswer ? Colors.green : Colors.red,
                        size: 28,
                      ),
                  ],
                ),
                value: option,
                activeColor: Colors.black,
                tileColor: Colors.white,
                groupValue: selectedOption,
                onChanged: (value) {
                  setState(() {
                    selectedOption = value;
                  });
                },
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: () {
            selectedOption == null ? null : submitted = true;
            setState(() {});
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
