import 'package:elgam3a/screens/home_screen.dart';
import 'package:elgam3a/utilities/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import 'input_text.dart';
import 'package:flrx_validator/flrx_validator.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String univCode;
  String password;
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

//   Future<void> _submit() async {
//     if (!_formKey.currentState.validate()) {
//       if (mounted)
//         setState(() {
//           _autoValidate = true;
//         });
//       return;
//     }
//     _formKey.currentState.save();
// //nasser
//     try {
//       LoadingScreen.show(context);
//       final String type =
//       await context.read<AuthProvider>().logIn(_email, _password);
//       final String user = context.read<AuthProvider>().uid;
//       if (type == t[0] || type == t[1]) {
//         Navigator.pushAndRemoveUntil(context,
//             MaterialPageRoute(builder: (_) => TabScreen()), (route) => false);
//       } else {
//         print('transporter');
//         await context
//             .read<OrdersProvider>()
//             .getOrderAcceptedByTransporter(user);
//         print('transporterrrrrrrrr');
//         final accepted = await context.read<OrdersProvider>().isAccepted();
//         print('isAccepted => $accepted');
//         if (accepted == true) {
//           final order = context.read<OrdersProvider>().orders.first;
//           print('orderModellll: $order');
//           Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => ChangeNotifierProvider<OrderProvider>(
//                   create: (_) => OrderProvider(orderModel: order),
//                   child: AcceptOrderScreenTransporter(),
//                 ),
//               ),
//                   (route) => false);
//         } else {
//           Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(builder: (_) => OrderRequestsScreen()),
//                   (route) => false);
//         }
//       }
//     } on FirebaseAuthException catch (e) {
//       Navigator.of(context).pop();
//       print(' error ${e.code}');
//       if (e.code == 'user-not-found') {
//         print(' error ${e.code}');
//         Alert(
//           context: context,
//           title: 'No user found for that email.',
//           buttons: [
//             DialogButton(
//               color: Color(0xff055261),
//               child: Text(
//                 'Okay',
//                 style: TextStyle(
//                   fontFamily: 'SF Pro Display',
//                   fontSize: 16,
//                   color: const Color(0xffb9cc66),
//                   fontWeight: FontWeight.w600,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//           ],
//         ).show();
//       } else if (e.code == 'wrong-password') {
//         print(' error ${e.code}');
//         Alert(
//           context: context,
//           title: 'Wrong password for that user.',
//           buttons: [
//             DialogButton(
//               color: Color(0xff055261),
//               child: Text(
//                 'Okay',
//                 style: TextStyle(
//                   fontFamily: 'SF Pro Display',
//                   fontSize: 16,
//                   color: const Color(0xffb9cc66),
//                   fontWeight: FontWeight.w600,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//           ],
//         ).show();
//       } else if (e.code == 'network-request-failed') {
//         print(' error ${e.code}');
//         Alert(
//           context: context,
//           title: 'please check your internet connection!',
//           buttons: [
//             DialogButton(
//               color: Color(0xff055261),
//               child: Text(
//                 'Okay',
//                 style: TextStyle(
//                   fontFamily: 'SF Pro Display',
//                   fontSize: 16,
//                   color: const Color(0xffb9cc66),
//                   fontWeight: FontWeight.w600,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//           ],
//         ).show();
//       } else {
//         print(' error ${e.code}');
//
//         Alert(
//           context: context,
//           title: 'error happened, please try again',
//           buttons: [
//             DialogButton(
//               color: Color(0xff055261),
//               child: Text(
//                 'Okay',
//                 style: TextStyle(
//                   fontFamily: 'SF Pro Display',
//                   fontSize: 16,
//                   color: const Color(0xffb9cc66),
//                   fontWeight: FontWeight.w600,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//           ],
//         ).show();
//       }
//     } catch (e) {
//       print(' error $e');
//       Navigator.of(context).pop();
//       Alert(
//         context: context,
//         title: 'something wrong happened, please try again',
//         buttons: [
//           DialogButton(
//             color: Color(0xff055261),
//             child: Text(
//               'Okay',
//               style: TextStyle(
//                 fontFamily: 'SF Pro Display',
//                 fontSize: 16,
//                 color: const Color(0xffb9cc66),
//                 fontWeight: FontWeight.w600,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//         ],
//       ).show();
//     }
//   }

  _login() async {
    if (!_formKey.currentState.validate()) {
      setState(() => _autoValidate = true);
      return;
    }
    _formKey.currentState.save();
    LoadingScreen.show(context);
    await Future.delayed(
      Duration(seconds: 2),
    );
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0, right: 30.0, left: 30.0),
      child: Form(
        key: _formKey,
        autovalidateMode:
            _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
//            Text(
//              'Hello ${widget.accountType} have a nice day.',
//              style: kWelcomeTextStyle,
//            ),
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
            // Space
            kSizedBox,
            ////
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
            // Space
            kSizedBox,
            ////
            FlatButton(
              child: Text(
                'Forgot your password ?',
                style: Theme.of(context).textTheme.headline1.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
              ),
//              textColor: kPrimaryColor,
              onPressed: () {},
            ),
            // Space
            kSizedBox,
            ////
            Center(
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                padding: kLoginButtonSize,
                color: Theme.of(context).cardColor,
                child: Text('Login'),
                textColor: kButtonTextColor,
                onPressed: () => _login(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
