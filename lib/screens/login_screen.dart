import 'package:elgam3a/providers/auth_provider.dart';
import 'package:elgam3a/providers/password_reset_provider.dart';
import 'package:elgam3a/screens/home_screen.dart';
import 'package:elgam3a/utilities/loading.dart';
import 'package:elgam3a/widgets/input_text.dart';
import 'package:elgam3a/widgets/leave_pop_up.dart';
import 'package:elgam3a/widgets/reset_password_pop_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flrx_validator/flrx_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String univCode;
  String password;
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  _login() async {
    if (!_formKey.currentState.validate()) {
      setState(() => _autoValidate = true);
      return;
    }
    _formKey.currentState.save();
    try {
      LoadingScreen.show(context);
      final email = await context
          .read<AuthProvider>()
          .getEmailOfStudentByUnivID(univCode);
      await context.read<AuthProvider>().logIn(email, password);
      Navigator.pop(context);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
          (route) => false);
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      print(' error ${e.code}');
      if (e.code == 'user-not-found') {
        print(' error ${e.code}');
        Alert(
          context: context,
          title: 'No user found for that email.',
          style: AlertStyle(
            alertElevation: 0,
          ),
          buttons: [
            DialogButton(
              color: Theme.of(context).cardColor,
              child: Text(
                'Okay',
                style: Theme.of(context).textTheme.button.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                textAlign: TextAlign.center,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ).show();
      } else if (e.code == 'wrong-password') {
        print(' error ${e.code}');
        Alert(
          context: context,
          title: 'Wrong password for that user.',
          style: AlertStyle(
            alertElevation: 0,
          ),
          buttons: [
            DialogButton(
              color: Theme.of(context).cardColor,
              child: Text(
                'Okay',
                style: Theme.of(context).textTheme.button.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                textAlign: TextAlign.center,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ).show();
      } else if (e.code == 'network-request-failed') {
        print(' error ${e.code}');
        Alert(
          context: context,
          title: 'Please check your internet connection!',
          style: AlertStyle(
            alertElevation: 0,
          ),
          buttons: [
            DialogButton(
              color: Theme.of(context).cardColor,
              child: Text(
                'Okay',
                style: Theme.of(context).textTheme.button.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                textAlign: TextAlign.center,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ).show();
      } else {
        print(' error ${e.code}');

        Alert(
          context: context,
          title: 'Error happened, please try again',
          style: AlertStyle(
            alertElevation: 0,
          ),
          buttons: [
            DialogButton(
              color: Theme.of(context).cardColor,
              child: Text(
                'Okay',
                style: Theme.of(context).textTheme.button.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                textAlign: TextAlign.center,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ).show();
      }
    } catch (e) {
      print(' error $e');
      Navigator.of(context).pop();
      // Alert(
      //   context: context,
      //   title: 'something wrong happened, please try again',
      //   buttons: [
      //     DialogButton(
      //       color: Theme.of(context).cardColor,
      //       child: Text(
      //         'Okay',
      //         style: Theme.of(context).textTheme.button.copyWith(
      //               fontSize: 16,
      //               fontWeight: FontWeight.w400,
      //             ),
      //         textAlign: TextAlign.center,
      //       ),
      //       onPressed: () => Navigator.of(context).pop(),
      //     ),
      //   ],
      // ).show();
      Alert(
        context: context,
        title: 'No user found for that id.',
        style: AlertStyle(
          alertElevation: 0,
        ),
        buttons: [
          DialogButton(
            color: Theme.of(context).cardColor,
            child: Text(
              'Okay',
              style: Theme.of(context).textTheme.button.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
              textAlign: TextAlign.center,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ).show();
    }
  }

  _forgetPassword() {
    showDialog(
      context: context,
      builder: (BuildContext context) => ResetPasswordPopUp(),
    );
  }

  _youWantLeave() {
    showDialog(
      context: context,
      builder: (BuildContext context) => LeavePopUp(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _emailSent = context.watch<PasswordResetProvider>().emailSent;
    return WillPopScope(
      onWillPop: () => _youWantLeave(),
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: constraints.maxWidth,
                  minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 50.0, horizontal: 30.0),
                child: Form(
                  key: _formKey,
                  autovalidateMode: _autoValidate
                      ? AutovalidateMode.always
                      : AutovalidateMode.disabled,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(),
                      Center(
                        child: SvgPicture.asset(
                          'assets/svg/big logo.svg',
                          height: 240,
                          width: 240,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          InputText(
                            validator: Validator(
                              rules: [
                                RequiredRule(
                                    validationMessage: 'ID is required.'),
                                MinLengthRule(11,
                                    validationMessage:
                                        'ID should be 11 number.'),
                                MaxLengthRule(11,
                                    validationMessage:
                                        'ID should be 11 number.'),
                              ],
                            ),
                            inputType: 'email',
                            maxLength: 11,
                            onSaved: (value) {
                              univCode = value;
                            },
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          InputText(
                            validator: Validator(
                              rules: [
                                RequiredRule(
                                    validationMessage: 'Password is required.'),
                              ],
                            ),
                            inputType: 'password',
                            onSaved: (value) {
                              password = value;
                            },
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          InkWell(
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text(
                                'Forgot your password ?',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    .copyWith(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                            onTap: () => _forgetPassword(),
                          ),
                          _emailSent
                              ? Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle_outline,
                                      color: Colors.green[300],
                                      size: 28,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Reset email sent, please check your mail.',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                    ),
                                  ],
                                )
                              : SizedBox(),
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: InkWell(
                          onTap: _login,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(18.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF000000).withOpacity(0.34),
                                  offset: Offset(0, 3),
                                  blurRadius: 6,
                                )
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'Login',
                                style:
                                    Theme.of(context).textTheme.button.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                              ),
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
        ),
      ),
    );
  }
}
