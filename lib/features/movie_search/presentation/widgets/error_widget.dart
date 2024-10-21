import 'package:flutter/material.dart';

class ErrorDisplay extends StatelessWidget {
    final String message;


    const ErrorDisplay({Key? key, required this.message}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Center( // Center the error message.
        child: Text(message, style: const TextStyle(color: Colors.red, fontSize: 16),));
  }
}
