import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dairy/util/screen_size.dart';

/// 自定义控件
class InputNote extends StatelessWidget {
  final String date;
  final String data;
  final double width;

  InputNote(
    this.date,
    this.data,
    this.width,
  );

  @override
  Widget build(BuildContext context) {
    var dateTp = TextPainter(
        text: TextSpan(
            text: 'Date: $date',
            style: TextStyle(
              fontSize: px36,
              color: Colors.black38,
              height: 3,
              fontFamily: 'VT323',
            )),
        textDirection: TextDirection.rtl)
      ..layout(maxWidth: width, minWidth: width);

    var dataTp = TextPainter(
        text: TextSpan(
            text: data,
            style: TextStyle(
              fontSize: px36,
              color: Colors.black87,
              height: 3,
              fontFamily: 'yrd',
            )),
        textDirection: TextDirection.ltr)
      ..layout(maxWidth: width, minWidth: 0);

    return CustomPaint(
      painter: InputNotePainter(dateTp, dataTp),
      size: Size(width, dataTp.height + px60),
    );
  }
}

class InputNotePainter extends CustomPainter {
  final TextPainter dateTp;
  final TextPainter dataTp;

  InputNotePainter(this.dateTp, this.dataTp);

  @override
  void paint(Canvas canvas, Size size) {
    dateTp.paint(canvas, Offset(0.0, 0.0));
    dataTp.paint(canvas, Offset(0.0, dateTp.height));
    final linePaint = Paint()
      ..color = Colors.black12
      ..strokeWidth = 1.1
      ..blendMode = BlendMode.hardLight
      ..isAntiAlias = true;
    double totalHeight = dataTp.height;
    int lineCount = dataTp.computeLineMetrics().length;
    double lineHeight = totalHeight / lineCount;
    for (int i = 0; i < lineCount; i++) {
      double l = i * lineHeight + 10 + dateTp.height;
      canvas.drawLine(Offset(0, l), Offset(size.width, l), linePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
