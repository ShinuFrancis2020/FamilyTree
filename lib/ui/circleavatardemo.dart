import 'package:flutter/material.dart';

class CircleAvatarLine extends StatelessWidget {
  const CircleAvatarLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Circle Avatar Line'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 100,
            decoration: BoxDecoration(border: Border.all()),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blue,
                  child: Text('A'),
                ),
                Divider(
                  color: Colors.redAccent, //color of divider
                  height: 5, //height spacing of divider
                  thickness: 3, //thickness of divier line
                  indent: 25, //spacing at the start of divider
                  endIndent: 25, //spacing at the end of divider
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.red,
                  child: Text('B'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0;

    Offset startPoint = Offset(0, size.height / 2);
    Offset endPoint = Offset(size.width, size.height / 2);

    canvas.drawLine(startPoint, endPoint, paint);

    // Offset avatarA = Offset(50, size.height / 2);
    // Offset avatarB = Offset(size.width - 50, size.height / 4);

    // canvas.drawCircle(avatarA, 50, paint);
    // canvas.drawCircle(avatarB, 50, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
