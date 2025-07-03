import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uz_travel/server/google_auth_service.dart';
import 'package:uz_travel/views/login/sign_in.dart';
import 'package:flutter/cupertino.dart';

class PasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  PasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => SignIn()),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30.w),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: Icon(Icons.keyboard_arrow_left),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 50.h),
          Center(
            child: Column(
              children: [
                Text(
                  "forget_password".tr(),
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  "we_have_sent_password_recovery_instruction".tr(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(height: 30.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "email".tr(),
                filled: true,
                fillColor: const Color(0xFFF7F7F9),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12.w),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "email_required".tr();
                }
                if (!value.contains("@")) {
                  return "email_invalid".tr();
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 55.h),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0D6EFD),
              fixedSize: Size(320.w, 50.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.w),
              ),
            ),
            onPressed: () async {
              final email = emailController.text.trim();

              if (email.isNotEmpty && email.contains("@")) {
                try {
                  await AuthService().sendPasswordResetEmail(
                    email,
                  ); // AuthService metodini chaqirish

                  showCupertinoDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CupertinoAlertDialog(
                        title: Icon(
                          CupertinoIcons.mail_solid,
                          size: 50.sp,
                          color: Color(0xFF0D6EFD),
                        ),
                        content: Column(
                          children: [
                            SizedBox(height: 10.h),
                            Text(
                              "check_your_email".tr(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              "we_have_sent_password_recovery_instruction".tr(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ],
                        ),
                        actions: [
                          CupertinoDialogAction(
                            isDefaultAction: true,
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => SignIn(),
                                ),
                              );
                            },
                            child: Text("OK".tr()),
                          ),
                        ],
                      );
                    },
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error: ${e.toString()}")),
                  );
                }
              } else {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("email_invalid".tr())));
              }
            },

            child: Text(
              "reset_password".tr(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
