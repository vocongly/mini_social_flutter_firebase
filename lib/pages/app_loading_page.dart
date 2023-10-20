import 'package:flutter/material.dart';

class AppLoadingPage extends StatelessWidget {
  const AppLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Text('S O C I A L',style: TextStyle(fontSize: 24),),
            SizedBox(height: 16,),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}