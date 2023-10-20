import 'dart:async';

import 'package:_logo/utils/src/utils/constant.dart';
import 'package:_logo/utils/src/utils/image_path.dart';
import 'package:flutter/material.dart';

const Duration _duration = Duration(milliseconds: 120);

const List<String> _logos = [
  ImagePath.fullPointLogo,
  ImagePath.fullPointLogo,
  ImagePath.fullPointLogo,
  ImagePath.twoPointLogo,
  ImagePath.onePointLogo,
  ImagePath.nullPointLogo,
  ImagePath.nullPointLogo,
  ImagePath.nullPointLogo,
  ImagePath.onePointLogo,
  ImagePath.onePointLogo,
  ImagePath.onePointLogo,
  ImagePath.twoPointLogo,
  ImagePath.twoPointLogo,
  ImagePath.twoPointLogo,
];

class AnimatedLogo extends StatefulWidget {
  final double? width;

  const AnimatedLogo({Key? key, this.width}) : super(key: key);

  @override
  State<AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo> {
  int _index = 0;
  late Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(_duration, (timer) => changePage());
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Image.asset(
              _logos[_index],
              width: widget.width,
              fit: BoxFit.fitWidth,
              gaplessPlayback: true,
              package: brickName,
            ),
          ),
        ));
  }

  void changePage() {
    if (_index == _logos.length - 1) {
      _index = 0;
    } else {
      _index++;
    }
    setState(() {});
  }
}
