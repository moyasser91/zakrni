import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  String hint ;
  String? Function(String?)? validatorUser;
  final TextEditingController myController ;
  TextInputType keyboardType ;


  TextForm({required this.hint ,this.keyboardType = TextInputType.text, required this.myController , required this.validatorUser});


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validatorUser,
      controller: myController,
      decoration: InputDecoration(
        labelText: hint,
        border: OutlineInputBorder(
            borderSide: BorderSide(width: 2,),
            borderRadius: BorderRadius.circular(12)
        ),

        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2,color: Colors.cyan),
            borderRadius: BorderRadius.circular(12)
        ),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2,color: Colors.red),
            borderRadius: BorderRadius.circular(12)
        ),
      ),
      style:Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black,fontSize: 17),
    );
  }
}
