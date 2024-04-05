import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final examProvider = ChangeNotifierProvider((ref) => ExamsProvider());

class ExamsProvider extends ChangeNotifier {
  int score = 0;

  addScore(bool value) {
    if (value) {
      score++;
      notifyListeners();
    }
  }
}
