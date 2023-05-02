// import 'package:flutter/services.dart';

// class EmailPhoneInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     String newText = newValue.text;
//     String formattedText = newText;
//     if (newText.length >= 10 && newText.contains("@")) {
//       return oldValue;
//     }
//     if (newText.contains("@")) {
//       formattedText = _formatEmail(newText);
//     } else if (newText.length >= 10) {
//       formattedText = _formatPhoneNumber(newText);
//     }
//     return newValue.copyWith(
//         text: formattedText,
//         selection: TextSelection.collapsed(offset: formattedText.length));
//   }
//    static RegExp exp = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
//   // static String _formatEmail(String newText) {
//   //   // Regular expression to check for valid email
//   //   RegExp exp = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
//   //   if (exp.hasMatch(newText)) {
//   //     return newText;
//   //   }
//   //   return "";
//   // }

//   String _formatPhoneNumber(String newText) {
//     // Regular expression to check for valid phone number
//     RegExp exp = RegExp(r"^[0-9]{10}$");
//     if (exp.hasMatch(newText)) {
//       String formattedPhone =
//           "+91 ${newText.substring(2, 6)} ${newText.substring(6)}";
//       // String formattedPhone =
//       //     "+91 ${newText.substring(0, 2)} ${newText.substring(8)}";
//       return formattedPhone;
//     }
//     return "";
//   }
// }
