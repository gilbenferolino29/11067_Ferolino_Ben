import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/src/global/constants.dart';
import 'package:todo_app/src/global/styles.dart';
import 'package:todo_app/src/screens/home.dart';
import 'package:todo_app/src/screens/login/auth_controller.dart';

import 'package:todo_app/src/size_configs.dart';

class Wrapper extends StatelessWidget {
  Wrapper({Key? key}) : super(key: key);
  final AuthController _authController = AuthController();
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _authController,
        builder: (context, Widget? w) {
          if (_authController.currentUser == null) {
            return AuthScreen(_authController);
          } else {
            return HomeScreen(_authController);
          }
        });
  }
}

class AuthScreen extends StatefulWidget {
  final AuthController auth;
  const AuthScreen(
    this.auth, {
    Key? key,
  }) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _unCon = TextEditingController(),
      _passCon = TextEditingController();
  String prompts = '';
  AuthController get _auth => widget.auth;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: sizeH * 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: sizeH * 40.5),
                Text(
                  'Sign in',
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: kSecondaryColor),
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
            Container(
              height: sizeV * 20,
              child: Image.asset(
                'assets/images/g-chat.png',
              ),
            ),
            SizedBox(height: sizeV * 6),
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
                          hintText: 'Username', focusColor: kPrimaryColor),
                      controller: _unCon,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: sizeV * 3),
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 75),
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
              onPressed: (_formKey.currentState?.validate() ?? false)
                  ? () {
                      bool result = _auth.login(_unCon.text, _passCon.text);
                      if (!result) {
                        setState(() {
                          prompts =
                              'Error logging in, username or password may be incorrect or the user has not been registered yet.';
                        });
                      }
                    }
                  : null,
              child: Text('Login', style: kTitle),
            ),
            SizedBox(height: sizeV * 19),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't Have an Account?",
                  style: kDesc,
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'SIGN UP',
                    style: kDesc2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
