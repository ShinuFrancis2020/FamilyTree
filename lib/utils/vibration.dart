import 'package:vibration/vibration.dart';

class VibrationClass {
  static success() async {
    if (await Vibration.hasVibrator() == true) {
      Vibration.vibrate(pattern: [20, 20, 20, 20]);
    }
  }

  static feedback() async {
    if (await Vibration.hasVibrator() == true) {
      Vibration.vibrate(pattern: [10, 10, 10, 10]);
    }
  }

  static feedbackOne() async {
    if (await Vibration.hasVibrator() == true) {
      Vibration.vibrate(pattern: [8, 8, 8, 8]);
    }
  }

  static invalid() async {
    if (await Vibration.hasVibrator() == true) {
      Vibration.vibrate(pattern: [50, 80, 50, 80]);
    }
  }
}
