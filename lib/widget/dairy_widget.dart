import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DairyText extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: VerticalText(text: "你好，这是垂直排版的文字，排版顺序从上到下，从右到左。😊😂😄",textStyle: TextStyle(fontSize: 15,color: Colors.red)
      ,width: 200,height: 200),
//      child: super.build(context),
    );
  }
}

// text aligns vertically, from top to bottom and right to left.
//
// 垂直布局的文字. 从右上开始排序到左下角.
class VerticalText extends CustomPainter {
  String text;
  double width;
  double height;
  TextStyle textStyle;

  VerticalText(
      {@required this.text,
        @required this.textStyle,
        @required this.width,
        @required this.height});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = new Paint();
    paint.color = textStyle.color;
    double offsetX = width;
    double offsetY = 0;
    bool newLine = true;
    double maxWidth = 0;

    maxWidth = findMaxWidth(text, textStyle);
  print("========maxWidth  $maxWidth");
    text.runes.forEach((rune) {
      String str = new String.fromCharCode(rune);
      TextSpan span = new TextSpan(style: textStyle, text: str);
      TextPainter tp = new TextPainter(
          text: span,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr);
      tp.layout();

      if (offsetY + tp.height > height) {
        newLine = true;
        offsetY = 0;
      }

      if (newLine) {
        offsetX -= maxWidth;
        newLine = false;
      }

      if (offsetX < -maxWidth) {
        return;
      }

      tp.paint(canvas, new Offset(offsetX, offsetY));
//      canvas.drawLine(p1, p2, paint)
      offsetY += tp.height;
    });
  }

  double findMaxWidth(String text, TextStyle style) {
    double maxWidth = 0;

    text.runes.forEach((rune) {
      String str = new String.fromCharCode(rune);
      TextSpan span = new TextSpan(style: style, text: str);
      TextPainter tp = new TextPainter(
          text: span,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr);
      tp.layout();
      maxWidth = max(maxWidth, tp.width);
    });

    return maxWidth+5;
  }

  @override
  bool shouldRepaint(VerticalText oldDelegate) {
    return oldDelegate.text != text ||
        oldDelegate.textStyle != textStyle ||
        oldDelegate.width != width ||
        oldDelegate.height != height;
  }

  double max(double a, double b) {
    if (a > b) {
      return a;
    } else {
      return b;
    }
  }
}