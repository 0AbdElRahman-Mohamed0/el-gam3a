import 'package:elgam3a/providers/auth_provider.dart';
import 'package:elgam3a/providers/password_reset_provider.dart';
import 'package:elgam3a/utilities/loading.dart';
import 'package:flrx_validator/flrx_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResetPasswordPopUp extends StatefulWidget {
  @override
  _ResetPasswordPopUpState createState() => _ResetPasswordPopUpState();
}

class _ResetPasswordPopUpState extends State<ResetPasswordPopUp> {
  final _formKey = GlobalKey<FormState>();
  String univCodeReset;
  bool _autoValidate = false;

  _resetPassword() async {
    if (!_formKey.currentState.validate()) {
      setState(() => _autoValidate = true);
      return;
    }
    _formKey.currentState.save();
    try {
      LoadingScreen.show(context);
      final email = await context
          .read<AuthProvider>()
          .getEmailOfStudentByUnivID(univCodeReset);
      await context.read<AuthProvider>().forgetPassword(email);
      context.read<PasswordResetProvider>().updateEmailSent(true);
      Navigator.pop(context);
      Navigator.pop(context);
    } catch (e, s) {
      Navigator.pop(context);
      print(e);
      print(s);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Reset password',
        style: Theme.of(context)
            .textTheme
            .headline1
            .copyWith(fontWeight: FontWeight.w700),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Form(
            key: _formKey,
            autovalidateMode: _autoValidate
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: TextFormField(
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 11,
              onSaved: (id) {
                univCodeReset = id;
              },
              keyboardType: TextInputType.number,
              validator: Validator<String>(
                rules: [
                  RequiredRule(
                    validationMessage: 'University Number is required.',
                  ),
                  MinLengthRule(
                    11,
                    validationMessage: 'University Number Must be 11 number.',
                  ),
                ],
              ),
              decoration: InputDecoration(
                labelText: 'ID',
                counterText: '',
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: _resetPassword,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              color: Theme.of(context).primaryColor,
              child: Text(
                'Reset Password',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
