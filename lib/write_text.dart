import 'package:flutter/material.dart';

class WriteText extends StatelessWidget {
  TextEditingController controllers;
  String label, hint, initialValue;
  double width;
  Icon prefixIcon;
  Widget suffixIcon;
  Function(String) onChanged;
  Function onComplete;

  WriteText(
      {this.controllers,
      this.label,
      this.hint,
      this.initialValue,
      this.width,
      this.prefixIcon,
      this.suffixIcon,
      this.onChanged,
      this.onComplete});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      child: TextField(
        onChanged: (value) {
          onChanged(value);
        },
        controller: controllers,
        onEditingComplete: onComplete,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.grey[400],
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.blue[300],
              width: 2.0,
            ),
          ),
          contentPadding: EdgeInsets.all(15.0),
          hintText: hint,
        ),
      ),
    );
  }
}
