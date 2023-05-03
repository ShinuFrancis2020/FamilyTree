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
        child: CustomPaint(
          painter: LinePainter(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue,
                child: Text('A'),
              ),
              SizedBox(height: 50),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.red,
                child: Text('B'),
              ),
            ],
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

    Offset avatarA = Offset(50, size.height / 2);
    Offset avatarB = Offset(size.width - 50, size.height / 4);

    canvas.drawCircle(avatarA, 50, paint);
    canvas.drawCircle(avatarB, 50, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
