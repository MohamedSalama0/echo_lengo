import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learning_letters_easy/presentation/screens/Home/view/home_screen.dart';
import 'package:learning_letters_easy/utils/app_colors.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.primaryColor,
          appBarTheme: AppBarTheme(
            centerTitle: true,
              backgroundColor: AppColors.primaryColor,
              iconTheme: const IconThemeData(
                color: Colors.white,
              )),
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
