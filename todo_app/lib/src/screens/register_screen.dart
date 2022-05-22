import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/src/global/constants.dart';
import 'package:todo_app/src/global/styles.dart';
import 'package:todo_app/src/screens/login/auth_controller.dart';
import 'package:todo_app/src/screens/login/auth_screen.dart';
import 'package:todo_app/src/size_configs.dart';

class RegisterScreen extends StatefulWidget {
  static const String route = 'register-screen';
  final AuthController auth;
  const RegisterScreen(this.auth, {Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _unCon = TextEditingController(),
      _passCon = TextEditingController();
  String prompts = '';
  AuthController get _auth => widget.auth;

  @override
  void dispose() {
    _unCon.dispose();
    _passCon.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: sizeH * 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: sizeH * 40.5),
                      Text(
                        'Sign up',
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: kPrimaryColor3,
                      ),
                    ),
                  ),
                  SizedBox(height: sizeV * 3),
                  Text('Create Your Account',
                      style: GoogleFonts.poppins(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromRGBO(27, 59, 154, 1))),
                  Text('Please enter info to create account',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      )),
                  SizedBox(height: sizeV * 6),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(prompts),
                  ),
                  Form(
                    key: _formKey,
                    onChanged: () {
                      _formKey.currentState?.validate();
                      if (mounted) {
                        setState(() {});
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        children: [
                          TextFormField(
                            style: kDesc,
                            decoration: InputDecoration(
                                hintText: 'Username',
                                focusColor: kPrimaryColor),
                            controller: _unCon,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: sizeV * 2),
                          TextFormField(
                            style: kDesc,
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: 'Password',
                            ),
                            controller: _passCon,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: sizeV * 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: kSecondaryColor,
                        padding: const EdgeInsets.symmetric(
                            vertical: 25, horizontal: 75),
                        shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                    onPressed: (_formKey.currentState?.validate() ?? false)
                        ? () {
                            String result =
                                _auth.register(_unCon.text, _passCon.text);
                            setState(() {
                              prompts = result;
                            });
                            Timer(
                                const Duration(seconds: 3),
                                () => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Wrapper())));
                          }
                        : null,
                    child: Text('Register', style: kTitle),
                  ),
                ],
              ),
              Positioned(
                bottom: sizeV * 5,
                left: sizeH * 15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already Have an Account?',
                      style: kDesc,
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Wrapper()));
                      },
                      child: Text(
                        'LOG IN',
                        style: kDesc2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
