import 'package:_logo/utils/src/utils/constant.dart';
import 'package:flutter/material.dart';

class StillLogo extends StatelessWidget {
  const StillLogo({
    Key? key,
    required this.logoImage,
    this.width,
  }) : super(key: key);

  final String logoImage;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Image.asset(
              logoImage,
              width: width,
              fit: BoxFit.fitWidth,
              gaplessPlayback: true,
              package: brickName,
            ),
          ),
        ));
  }
}
