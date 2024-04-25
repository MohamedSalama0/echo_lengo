import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning_letters_easy/presentation/screens/choose%20language/view/choose_language_screen.dart';
import 'package:learning_letters_easy/presentation/screens/login/controller/login_provider.dart';
import 'package:learning_letters_easy/presentation/screens/login/view/login_screen.dart';
import 'package:learning_letters_easy/presentation/shared_widgets/custom_button.dart';
import 'package:learning_letters_easy/utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> titleTabs = [
    'Questions\n& Exams',
    'Content',
    'About',
    'Settings',
    'Notifications',
    'Logout',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  Consumer(
                    builder: (context, ref, child) {
                      var prov = ref.read(loginProvider);
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Welcome  ',
                            style: TextStyle(
                              color: kWhite,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            '${prov.userNameController.text} :)',
                            style: const TextStyle(
                              color: kYellow,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 60.h),
                  GridView.count(
                    physics: const BouncingScrollPhysics(),
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    crossAxisSpacing: 20,
                    semanticChildCount: 2,
                    mainAxisSpacing: 20,
                    children: [
                      tab(0, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChooseLanguageScreen(
                                comingFormContentScreen: false),
                          ),
                        );
                      }),
                      tab(1, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChooseLanguageScreen(
                                comingFormContentScreen: true),
                          ),
                        );
                      }),
                      tab(2, () {}),
                      tab(3, () {
                        
                      }),
                      tab(4, () {}),
                      Consumer(
                        builder: (BuildContext context, WidgetRef ref,
                            Widget? child) {
                          return tab(5, () {
                            ref.read(loginProvider).userNameController.clear();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget tab(int index, VoidCallback? onTap) {
    var icons = [
      Icons.question_answer_outlined,
      Icons.video_library_outlined,
      Icons.info_outline,
      Icons.settings,
      Icons.notifications_on_rounded,
      Icons.logout,
    ];
    return CustomButton(
      onTap: onTap ?? () {},
      text: titleTabs[index],
      iconWidth: 40.w,
      iconData: icons[index],
    );
  }
}
