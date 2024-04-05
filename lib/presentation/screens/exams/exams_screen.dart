import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:learning_letters_easy/presentation/screens/exams/exams_provider.dart';
import 'package:learning_letters_easy/presentation/shared_widgets/static_letters.dart';
import 'package:learning_letters_easy/utils/app_style.dart';

class Exam {
  String answer;
  List<String> paths = [];
  Exam({
    required this.answer,
    required this.paths,
  });
}

class ExamsScreen extends ConsumerStatefulWidget {
  final bool isEnglish;
  const ExamsScreen({super.key, required this.isEnglish});

  @override
  ConsumerState<ExamsScreen> createState() => _ExamsScreenState();
}

class _ExamsScreenState extends ConsumerState<ExamsScreen> {
  final PageController _pageController = PageController();
  static const String enVidPath = 'assets/screenshots/en';
  static const String arVidPath = 'assets/screenshots/ar';
  List<String> paths = [];
  Random random = Random();
  int randomNum = 0;
  List<String> randomList = [];
  List<String> userAnswers = [];
  int score = 0;
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    paths = letters();
    ref.read(examProvider).score = 0;
    randomNum = widget.isEnglish ? random.nextInt(10) : random.nextInt(10);
  }

  String getLetterArByIndex(index) {
    switch (index) {
      case 1:
        return 'ا';
      case 2:
        return 'ب';
      case 3:
        return 'ت';
      case 4:
        return 'ث';
      case 5:
        return 'ح';


    }
  }

  List<String> getRandomLetters() {
    List<String> randomLetters =
        List.from(widget.isEnglish ? lettersEnglish : lettersArabic);
    randomLetters.shuffle();
    return randomLetters.sublist(0, 10);
  }

  List<String> letters() {
    List<String> paths = [];
    if (widget.isEnglish) {
      randomList = getRandomLetters();
      for (String letter in randomList) {
        paths.add('$enVidPath/$letter.png');
      }
    } else {
      randomList = getRandomLetters();
      for (int index = 0; index < randomList.length; index++) {
        print(randomList.toString());
        paths.add('$arVidPath/ar${index + 1}.png');
      }
    }
    paths.shuffle();
    return paths;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: const Text(
          'المراجعة\n10/10',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: paths.length,
        itemBuilder: (context, index) {
          print('randomList[index]');
          print(randomList[index]);
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Image.asset(paths[index]),
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
                        index: index,
                        isEnglish: widget.isEnglish,
                        pageController: _pageController,
                        lettersList: randomList,
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class RadioButtonWidget extends StatefulWidget {
  const RadioButtonWidget({
    super.key,
    required this.index,
    required this.isEnglish,
    required this.lettersList,
    required this.pageController,
  });
  final int index;
  final PageController pageController;
  final bool isEnglish;
  final List<String> lettersList;
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
      List<String> alphabet = List<String>.from(
        widget.lettersList,
      );
      alphabet.removeAt(widget.index);
      alphabet.shuffle();

      int correctIndex = Random().nextInt(3);
      alphabet.insert(correctIndex, widget.lettersList[widget.index]);

      options = alphabet.sublist(0, 3);

      correctAnswer = options[correctIndex];
    } else {
      var alphabetsAr = List<String>.from(widget.lettersList);
      if (alphabetsAr.contains(widget.lettersList[widget.index])) {
        alphabetsAr.remove(widget.lettersList[widget.index]);
      }

// Shuffle the list of options
      alphabetsAr.shuffle();

// Ensure the correct answer is included in the options
      int correctIndex =
          Random().nextInt(3); // Generate a random index for the correct answer
      alphabetsAr.insert(correctIndex, widget.lettersList[widget.index + 1]);

// Ensure we have exactly 3 options
      options = alphabetsAr.take(3).toList();
      print(options.toString());
// Shuffle options again to randomize their order
      options.shuffle();

// Set the correct answer
      correctAnswer = widget.lettersList[widget.index + 1];
      print(correctAnswer);
    }
  }

  void showScoreBottomSheet(int degree) {
    showModalBottomSheet(
      context: context,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      useSafeArea: true,
      constraints: BoxConstraints(maxHeight: sizedH(context) * 0.40),
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.grey[300],
          body: SizedBox(
            width: double.infinity,
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(18)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: sizedH(context) * 0.02),
                  const Text(
                    'Test Completed',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: sizedH(context) * 0.08),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.green[400],
                    ),
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Your score is: $degree out of 10',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: sizedH(context) * 0.10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Close'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
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
                title: Text(
                  '$option ',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
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
        Consumer(
          builder: (context, ref, child) {
            return ElevatedButton(
              onPressed: () {
                if (selectedOption != null) {
                  print(ref.watch(examProvider).score.toString());
                  ref
                      .read(examProvider)
                      .addScore(selectedOption == correctAnswer);
                  if (widget.index + 1 == 10) {
                    showScoreBottomSheet(ref.watch(examProvider).score);
                  }
                  widget.pageController.animateToPage(
                    widget.index + 1,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOut,
                  );
                  print(ref.watch(examProvider).score.toString());
                }
              },
              child: const Text('Submit'),
            );
          },
        ),
      ],
    );
  }
}
