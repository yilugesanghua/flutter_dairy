import 'package:flutter/material.dart';

/// 水波纹效果 按钮点击效果等
class InkWidget extends StatefulWidget {
  InkWidget({
    this.child,
    this.borderRadius,
    this.normalColor,
    this.highlightShape: BoxShape.rectangle,
    this.splashColor,
    this.highlightColor,
    this.containedInkWell: true,
    this.border,
    this.margin,
    this.onHighlightChanged,
    this.onTap,
    this.onTapDown,
    this.onTapCancel,
    this.onDoubleTap,
    this.onLongPress,
  });

  final Widget child;
  final Color normalColor;
  final BorderRadiusGeometry borderRadius;
  final BoxShape highlightShape;

  final Color splashColor;
  final Color highlightColor;
  final bool containedInkWell;
  final Border border;
  final EdgeInsetsGeometry margin;

  final ValueChanged<bool> onHighlightChanged;
  final GestureTapCallback onTap;
  final GestureTapDownCallback onTapDown;
  final GestureTapCallback onTapCancel;
  final GestureTapCallback onDoubleTap;
  final GestureLongPressCallback onLongPress;

  @override
  State<StatefulWidget> createState() {
    return InkWidgetState();
  }
}

class InkWidgetState extends State<InkWidget> {
  @override
  Widget build(BuildContext context) {
    return _buildInk(widget.child,
        highlightColor: widget.highlightColor,
        borderRadius: widget.borderRadius,
        normalColor: widget.normalColor,
        highlightShape: widget.highlightShape,
        splashColor: widget.splashColor,
        containedInkWell: widget.containedInkWell,
        border: widget.border,
        margin: widget.margin,
        onHighlightChanged: widget.onHighlightChanged,
        onTap: widget.onTap,
        onTapDown: widget.onTapDown,
        onTapCancel: widget.onTapCancel,
        onDoubleTap: widget.onDoubleTap,
        onLongPress: widget.onLongPress);
  }

  Widget _buildInk(
    Widget child, {
    BorderRadiusGeometry borderRadius,
    Color normalColor,
    BoxShape highlightShape = BoxShape.rectangle,
    Color splashColor,
    Color highlightColor,
    bool containedInkWell = true,
    Border border,
    EdgeInsetsGeometry margin,
    final ValueChanged<bool> onHighlightChanged,
    final GestureTapCallback onTap,
    final GestureTapDownCallback onTapDown,
    final GestureTapCallback onTapCancel,
    final GestureTapCallback onDoubleTap,
    final GestureLongPressCallback onLongPress,
  }) {
    return new Container(
      margin: margin,
      child: Material(
        color: Colors.transparent,
        child: new Ink(
          decoration: new BoxDecoration(
              color: normalColor, borderRadius: borderRadius, border: border),
          child: new InkResponse(
            borderRadius: borderRadius,
            containedInkWell: containedInkWell,
            highlightShape: highlightShape,
            highlightColor: highlightColor,
            splashColor: splashColor,
            onTap: onTap,
            onHighlightChanged: onHighlightChanged,
            onDoubleTap: onDoubleTap,
            onLongPress: onLongPress,
            onTapCancel: onTapCancel,
            onTapDown: onTapDown,
            child: child,
          ),
        ),
      ),
    );
  }
}
