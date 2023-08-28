import 'package:flutter/material.dart';

import 'custome_text.dart';

class CustomField extends StatelessWidget {

  final String hint;

  //final TextEditingController controller;
  dynamic validator;
  dynamic onSaved;

  TextDirection textDire;
  TextAlign textAlign;

  TextInputType textInputType;

  CustomField({
    super.key,
    required this.hint,
    required this.validator,
    required this.onSaved,
    //required this.controller,
    required this.textDire,
    required this.textAlign,
    required this.textInputType
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [

          TextFormField(
            //controller: controller,
            keyboardType: textInputType,
            validator: validator,
            onSaved: onSaved,
            textDirection: textDire,
            textAlign: textAlign,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                  fontWeight: FontWeight.w100,
                  color: Color(0xff676464FF),
                  fontSize: 14
              ),
              fillColor: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}