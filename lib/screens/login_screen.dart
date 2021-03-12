import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elgam3a/providers/auth_provider.dart';
import 'package:elgam3a/providers/password_reset_provider.dart';
import 'package:elgam3a/screens/home_screen.dart';
import 'package:elgam3a/utilities/loading.dart';
import 'package:elgam3a/widgets/input_text.dart';
import 'package:elgam3a/widgets/leave_pop_up.dart';
import 'package:elgam3a/widgets/login_app_bar.dart';
import 'package:elgam3a/widgets/reset_password_pop_up.dart';
import 'package:flrx_validator/flrx_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    } on FirebaseException catch (e, s) {
      Navigator.pop(context);
      print(e);
      print(s);
    } catch (e, s) {
      Navigator.pop(context);
      print(e);
      print(s);
    }
  }

  _forgetPassword() async {
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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: LoginAppBar(
            title: Text(
              'El-Gam3a',
              style: Theme.of(context).textTheme.button.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
          child: Form(
            key: _formKey,
            autovalidateMode: _autoValidate
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Container(
                    height: 100.0,
                    width: 100.0,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(height: 36),
                InputText(
                  validator: Validator(
                    rules: [
                      RequiredRule(validationMessage: 'ID is required.'),
                      MinLengthRule(11,
                          validationMessage: 'ID should be 11 number.'),
                      MaxLengthRule(11,
                          validationMessage: 'ID should be 11 number.'),
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
                      RequiredRule(validationMessage: 'Password is required.'),
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
                      style: Theme.of(context).textTheme.headline1.copyWith(
                            fontSize: 12.0,
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
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ],
                      )
                    : SizedBox(),
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
                          style: Theme.of(context).textTheme.button,
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
    );
  }
}
