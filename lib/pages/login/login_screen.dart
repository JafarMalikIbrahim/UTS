import 'dart:core';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:manajemen_aset/widget/input_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool loading = false;
  bool securePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();

    super.dispose();
  }

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            child: Stack(
              children: [
                SizedBox(
                  height: size.height,
                  child: Image.asset(
                    'img/login.jpg',
                    // #Image Url: https://unsplash.com/photos/bOBM8CB4ZC4
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      const Expanded(
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 7,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
                            child: SizedBox(
                              width: size.width * .9,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: size.width * .15,
                                      bottom: size.width * .1,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          'LOGIN',
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white.withOpacity(.8),
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        Text(
                                          'Manajemen Aset',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white.withOpacity(.8),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // email input form
                                  component(
                                    Iconsax.sms,
                                    'Email...',
                                    false,
                                    true,
                                  ),
                                  // password input form
                                  component(
                                    Iconsax.lock_1,
                                    'Password...',
                                    true,
                                    false,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: 'Forgotten password!',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          // HapticFeedback.lightImpact();
                                          // Fluttertoast.showToast(
                                          //   msg:
                                          //       'Forgotten password! button pressed',
                                          // );
                                        },
                                    ),
                                  ),
                                  SizedBox(height: size.width * .3),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      signIn();
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        bottom: size.width * .05,
                                      ),
                                      height: size.width / 8,
                                      width: size.width / 1.25,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            146, 204, 228, 144),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Text(
                                        'Login',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget component(
      IconData icon, String hintText, bool isPassword, bool isEmail) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.width / 8,
      width: size.width / 1.25,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: size.width / 30),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.1),
        borderRadius: BorderRadius.circular(20),
      ),
      // child: LoginForm(
      //   controller: isEmail ? emailController : passController,
      //   obscureText: isEmail ? false : securePassword,
      //   inputType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      //   prefixIcon: icon,
      //   hintTxt: hintText,
      //   sufixIcon: isPassword
      //       ? IconButton(
      //           icon: securePassword
      //               ? const Icon(
      //                   Icons.visibility_off,
      //                   color: Color.fromARGB(248, 34, 36, 33),
      //                 )
      //               : const Icon(
      //                   Icons.remove_red_eye,
      //                   color: Color.fromARGB(146, 204, 228, 144),
      //                 ),
      //           onPressed: () {
      //             if (securePassword) {
      //               setState(() {
      //                 securePassword = false;
      //               });
      //             } else {
      //               setState(() {
      //                 securePassword = true;
      //               });
      //             }
      //           },
      //         )
      //       : null,
      //   validator: (val) {
      //     if (val!.isEmpty) {
      //       return 'Wajib diisi';
      //     }
      //     return null;
      //   },
      // ),
      child: TextFormField(
        cursorColor: const Color.fromARGB(146, 204, 228, 144),
        style: TextStyle(
          color: Colors.white.withOpacity(.9),
        ),
        controller: isEmail ? emailController : passController,
        obscureText: isEmail ? false : securePassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.white.withOpacity(.8),
          ),
          border: InputBorder.none,
          hintMaxLines: 1,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(.5),
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: securePassword
                      ? const Icon(
                          Iconsax.eye_slash,
                          color: Color.fromARGB(248, 34, 36, 33),
                        )
                      : const Icon(Iconsax.eye,
                          color: Color.fromARGB(146, 204, 228, 144)),
                  onPressed: () {
                    if (securePassword) {
                      setState(() {
                        securePassword = false;
                      });
                    } else {
                      setState(() {
                        securePassword = true;
                      });
                    }
                  },
                )
              : null,
        ),
      ),
    );
  }
}

// widget header
Widget loginHeaderWidget() {
  return Column(
    children: [
      const SizedBox(
        height: 20,
      ),
      Image.asset(
        "img/login.png",
        width: 200,
      ),
    ],
  );
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}
