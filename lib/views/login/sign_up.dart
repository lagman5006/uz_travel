import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:uz_travel/gen/assets.gen.dart';
import 'package:uz_travel/view_madels/uztravel_provider.dart';
import 'package:uz_travel/views/home_page.dart';
import 'package:uz_travel/views/login/sign_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController firsNameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<UzTravelProvider>(
      builder: (context, uzTravelProvider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.keyboard_arrow_left),
                ),
              ),
            ),

            actions: [
              PopupMenuButton<Locale>(
                icon: const Icon(Icons.language, color: Colors.black),
                onSelected: (Locale locale) {
                  context.setLocale(locale);
                },
                itemBuilder: (BuildContext context) => [
                  const PopupMenuItem(
                    value: Locale('en'),
                    child: Text('English'),
                  ),
                  const PopupMenuItem(
                    value: Locale('ru'),
                    child: Text('Русский'),
                  ),
                  const PopupMenuItem(
                    value: Locale('uz'),
                    child: Text("O'zbekcha"),
                  ),
                ],
              ),
            ],
          ),

          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),
                      Center(
                        child: Column(
                          children: [
                            Text(
                              'sign_up_now'.tr(),
                              style: TextStyle(
                                fontSize: 23.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'please_fill_details'.tr(),
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 10.h),
                      TextFormField(
                        controller: firsNameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: 'first_name'.tr(),
                          filled: true,
                          fillColor: const Color(0xFFF7F7F9),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'first_name_required'.tr();
                          }
                          if (value.length < 2) {
                            return 'first_name_invalid'.tr();
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),
                      TextFormField(
                        controller: lastNameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: 'last_name'.tr(),
                          filled: true,
                          fillColor: const Color(0xFFF7F7F9),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'last_name_required'.tr();
                          }
                          if (value.length < 2) {
                            return 'last_name_invalid'.tr();
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'email'.tr(),
                          filled: true,
                          fillColor: const Color(0xFFF7F7F9),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'email_required'.tr();
                          }
                          if (!value.contains("@")) {
                            return 'email_invalid'.tr();
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),
                      TextFormField(
                        controller: passwordController,
                        obscureText: obscureText,
                        decoration: InputDecoration(
                          hintText: 'password'.tr(),
                          filled: true,
                          fillColor: const Color(0xFFF7F7F9),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            icon: Icon(
                              obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'password_hint'.tr(),
                        style: const TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 10.h),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0D6EFD),
                          fixedSize: Size(320.w, 50.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          uzTravelProvider.signUp(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                            firsNameController.text.trim(),
                            lastNameController.text.trim(),
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        },
                        child: Text(
                          'sign_up'.tr(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: 'already_have_account'.tr(),
                            style: const TextStyle(color: Colors.grey),
                            children: [
                              TextSpan(
                                text: 'sign_in'.tr(),
                                style: const TextStyle(
                                  color: Color(0xFF0D6EFD),
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignIn(),
                                      ),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Center(
                        child: Text(
                          'or_connect'.tr(),
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Assets.svgs.google.svg(width: 30.w, height: 30.h),
                          SizedBox(width: 10.w),
                          Assets.svgs.facebook.svg(width: 30.w, height: 30.h),
                          SizedBox(width: 10.w),
                          Assets.svgs.twitter.svg(width: 30.w, height: 30.h),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
