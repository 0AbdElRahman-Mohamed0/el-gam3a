import 'package:flrx_validator/flrx_validator.dart';
import 'package:flutter/material.dart';
import '../utilities/constants.dart';

class InputText extends StatefulWidget {
  InputText({
    @required this.inputType,
    @required this.onSaved,
    @required this.person,
    this.validator,
  });
  final String inputType;
  final Function onSaved;
  final String person;
  final Validator validator;
  @override
  _InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  // Email or password
  String inputType;
  // Custom onChanged
  Function onSaved;
  // Student or doctor
  String person;
  // To check
  bool _isHidden = true;
  Validator validator;

  @override
  void initState() {
    super.initState();
    inputType = widget.inputType;
    person = widget.person;
    onSaved = widget.onSaved;
    validator = widget.validator;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: TextFormField(
        onSaved: onSaved,
        validator: validator,
        style: kTextFieldInputStyle,
        decoration: InputDecoration(
//          focusedBorder: kSelectedTextFieldColor,
          filled: true,
          fillColor: Colors.white,

          // Icon before text
          prefixIcon: inputType == 'password'
              ? Icon(
                  Icons.lock,
                )
              : Icon(
                  Icons.email,
                ),
          //// I mean if inputType is password put lock icon else put email icon

          // Icon after text
          suffixIcon: inputType == 'password'
              ? IconButton(
                  icon: _isHidden
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _isHidden = !_isHidden;
                    });
                  },
                )
              : null,
          //// I mean if it password put IconButton else put null means don't put anything
          //// If it password check if isHidden == true but visibility off icon
          //// Else put visibility

          // The inbox hint what i can do here
          hintText: inputType == 'password'
              ? 'Password'
              : person == 'student'
                  ? 'University Number'
                  : 'University Code',
          //// If inputType is password write a hint password else check if
          //// Person is a student put hint university number else put hint university code

          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          border: kTextFieldCircularBorder,
        ),

        // This makes password invisible
        obscureText: inputType == 'password' ? _isHidden : false,
        //// If inputType is password put the status isHidden if it now equal true or false
        //// Else always make it false

        // This makes keyboard just numbers for this field
        keyboardType: inputType == 'email' ? TextInputType.number : null,
        //// If inputType is email make keyboard only numbers else do nothing

        // Change cursor color of tet field
        cursorColor: kPrimaryColor,
        ////
      ),

      // To change color of input text border and icons when pressed
      data: Theme.of(context).copyWith(
        primaryColor: kPrimaryColor,
      ),
      //// To use this property we make it into Theme widget
    );
  }
}
