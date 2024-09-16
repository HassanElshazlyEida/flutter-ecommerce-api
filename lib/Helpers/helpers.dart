
import 'package:flutter/material.dart';

class Helpers {
  static String apiUrl = 'https://student.valuxapps.com/api';

  static TextFormField formField({required TextEditingController controller, required String hint, String? label, bool? isPassword}){
  return TextFormField(
    controller: controller,
    validator: (value) {
      if (value!.isEmpty) {
        return 'Please enter your ${label ?? hint}';
      }
      return null;
    },
    obscureText: isPassword ?? false,
    decoration:  InputDecoration(
      border: const OutlineInputBorder(),
      labelText: label,
      hintText: hint,
    ),
  );
  }
  static AlertDialog errorDialog({required BuildContext context, required String message}){
    return AlertDialog(
      content: Text(message,style: const  TextStyle(color: Colors.white)),
      backgroundColor: Colors.red,
      actions: [
        TextButton(onPressed: () {
          Navigator.pop(context);
        }, child: const Center(child:  Text('OK')))
      ],
    );
  }
}