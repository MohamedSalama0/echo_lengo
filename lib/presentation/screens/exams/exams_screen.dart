import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:learning_letters_easy/presentation/screens/exams/exams_provider.dart';
import 'package:learning_letters_easy/presentation/shared_widgets/static_letters.dart';
import 'package:learning_letters_easy/utils/app_style.dart';

class Exam {
  String path = '';
  String letter = '';
  Exam({
    required this.path,
    required this.letter,
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
  List<Exam> exam = [];
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
    exam = letters();
    ref.read(examProvider).score = 0;
    randomNum = widget.isEnglish ? random.nextInt(10) : random.nextInt(10);
    _pageController.addListener(() {
      setState(() {
        questionNumber = _pageController.page!.round() + 1;
      });
    });
  }

  List<String> getRandomLetters() {
    List<String> randomLetters =
        List.from(widget.isEnglish ? lettersEnglish : lettersArabic);
    randomLetters.shuffle();
    return randomLetters.sublist(0, 10);
  }

  int getIndexByArabicLetter(String letter) {
    if (letter.length != 1 || !lettersArabic.contains(letter)) {
      throw Exception('Invalid Arabic letter provided');
    }

    return lettersArabic.indexOf(letter) + 1;
  }

  List<Exam> letters() {
    List<Exam> exams = [];
    if (widget.isEnglish) {
      randomList = getRandomLetters();
      for (String letter in randomList) {
        exams.add(Exam(path: '$enVidPath/$letter.png', letter: letter));
      }
    } else {
      randomList = getRandomLetters();

      for (String letter in randomList) {
        int letterIndex = getIndexByArabicLetter(letter);
        print('letter=> $letter');
        exams.add(
          Exam(
            path: '$arVidPath/ar$letterIndex.png',
            letter: letter,
          ),
        );
      }
    }
    exams.shuffle();
    return exams;
  }

  int questionNumber = 1;

  @override
  Widget build(BuildContext context) {
    print('rebuilddd');
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: Text(
          'المراجعة\n10/$questionNumber',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: exam.length,
        itemBuilder: (context, index) {
          print('randomList[index]');
          print(randomList.toString());
          print(exam[index].letter);
          print(exam[index].path);
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Image.asset(exam[index].path),
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
                        correctAnswer: exam[index].letter,
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
    required this.correctAnswer,
  });
  final int index;
  final PageController pageController;
  final bool isEnglish;
  final String correctAnswer;
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
      List<String> alphabet = List.from(widget.lettersList);

      if (alphabet.contains(widget.correctAnswer)) {
        alphabet.remove(widget.correctAnswer);
      }

      alphabet.shuffle();
      correctAnswer = widget.correctAnswer;
      options = alphabet.take(2).toList() ..add(correctAnswer!);
    } else {
      var alphabetsAr = List<String>.from(widget.lettersList);
      print('coreect answer => ${widget.correctAnswer}');
      if (alphabetsAr.contains(widget.correctAnswer)) {
        alphabetsAr.remove(widget.correctAnswer);
      }

      correctAnswer = widget.correctAnswer;

      alphabetsAr.shuffle();
      options = alphabetsAr.take(2).toList()..add(correctAnswer!);
      print('options list => ${options.toString()}');
    }

    options.shuffle();
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
