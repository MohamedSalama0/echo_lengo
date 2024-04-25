import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning_letters_easy/presentation/screens/Home/view/home_screen.dart';
import 'package:learning_letters_easy/presentation/screens/login/view/login_screen.dart';
import 'package:learning_letters_easy/utils/app_colors.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: ScreenUtilInit(

        builder:(context, child) => MaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: kPrimaryColor,
            appBarTheme: AppBarTheme(
              centerTitle: true,
                backgroundColor: kPrimaryColor,
                iconTheme: const IconThemeData(
                  color: Colors.white,
                )),
          ),
          home: child,
          debugShowCheckedModeBanner: false,
        ),
        child: const LoginScreen(),
      ),
    );
  }
}
