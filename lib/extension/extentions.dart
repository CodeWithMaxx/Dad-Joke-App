import 'package:flutter/material.dart';

extension stringExtentions on String {
  bool isValidName(BuildContext context) {
    if (length < 5) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog.adaptive(
              title:const Text('name should be minimum 5 letters',style: TextStyle(fontSize: 15,color: Colors.red),),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK')),
                ],
              )));
    }
    return length > 5;
  }
}
