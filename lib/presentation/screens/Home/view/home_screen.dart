import 'package:flutter/material.dart';
import 'package:learning_letters_easy/presentation/screens/alphabets/view/alphabets_screen.dart';
import 'package:learning_letters_easy/presentation/shared_widgets/custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> titleTabs = [
    'Questions',
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
              child: GridView.count(
                physics: const BouncingScrollPhysics(),
                crossAxisCount: 2,
                shrinkWrap: true,
                crossAxisSpacing: 20,
                semanticChildCount: 2,
                mainAxisSpacing: 20,
                children: [
                  tab(0, () {}),
                  tab(1, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AlphabetsScreen(),
                      ),
                    );
                  }),
                  tab(2, () {}),
                  tab(3, () {}),
                  tab(4, () {}),
                  tab(5, () {}),
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
      icon: icons[index],
    );
  }
}
