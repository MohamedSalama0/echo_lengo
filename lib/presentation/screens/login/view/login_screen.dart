import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning_letters_easy/presentation/screens/Home/view/home_screen.dart';
import 'package:learning_letters_easy/presentation/screens/login/controller/login_provider.dart';
import 'package:learning_letters_easy/presentation/screens/login/widgets/custom_text_field.dart';
import 'package:learning_letters_easy/presentation/shared_widgets/custom_button.dart';
import 'package:learning_letters_easy/utils/app_colors.dart';
import 'package:learning_letters_easy/utils/app_style.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Consumer(
          builder: (context, ref, child) {
            var prov = ref.read(loginProvider);
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Form(
                  key: prov.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: sizedH(context) * 0.15),
                      Text(
                        'Welcome To ',
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Echo Lengo ',
                        style: TextStyle(
                          color: kYellow,
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: sizedH(context) * 0.18),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 12.w, bottom: 5.h),
                            child: const Text(
                              'User Name',
                              style: TextStyle(color: kWhite, fontSize: 16),
                            ),
                          ),
                          DefaultTextFormField(
                            hintText: 'Enter Your Name',
                            controller: prov.userNameController,
                            type: TextInputType.name,
                            validate: (v) {
                              if (v == null || v.isEmpty) {
                                return 'Please Enter Your Name!';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: sizedH(context) * 0.08),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 50.w,
                        ),
                        child: CustomButton(
                          // height: 55.h,
                          // width: 170.w,
                          onTap: () {
                            if (prov.formKey.currentState!.validate()) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                              );
                            }
                          },
                          text: 'Login',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
