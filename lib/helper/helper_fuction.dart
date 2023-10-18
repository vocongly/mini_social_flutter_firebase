import 'package:flutter/material.dart';

void showMessageToUser(String message, BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar( SnackBar(
     content: Text(message),
));
}