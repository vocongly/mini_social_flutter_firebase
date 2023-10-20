import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRBrick {
  static Widget scanArea({
    required BuildContext context,
    required ValueChanged<String> done,
  }) {
    final MobileScannerController mobileScannerController =
        MobileScannerController(
            detectionSpeed: DetectionSpeed.normal,
            facing: CameraFacing.back,
            returnImage: true);
    return MobileScanner(
        controller: mobileScannerController,
        onDetect: (capture) {
          final result = capture.raw[0]["rawValue"];
          done(result.toString());
        });
  }
}
