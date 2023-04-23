import 'package:flutter/material.dart';

class MyCustomWidget extends State {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyCustomPainter(
        onUpdate: (start, end) {
          setState(() {});
        },
      ),
      size: Size.infinite,
    );
  }
}

class MyCustomPainter extends CustomPainter {
  MyCustomPainter({required this.onUpdate});

  final void Function(Offset start, Offset end) onUpdate;

  late Offset start;
  late Offset end;

  @override
  void paint(Canvas canvas, Size size) {
    // Define your painting logic here, using the provided canvas and size parameters
    // For example, you could draw lines, shapes, or text on the canvas

    // Draw the first node
    final nodeSize = 50.0;
    final nodeMargin = 20.0;
    final firstNodeRect = Rect.fromLTWH(
      start.dx,
      start.dy,
      nodeSize,
      nodeSize,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(firstNodeRect, Radius.circular(5.0)),
      Paint()..color = Colors.blue,
    );

    // Draw the second node
    final secondNodeRect = Rect.fromLTWH(
      end.dx,
      end.dy,
      nodeSize,
      nodeSize,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(secondNodeRect, Radius.circular(5.0)),
      Paint()..color = Colors.green,
    );

    // Draw the edge
    final edgeStart = Offset(
      firstNodeRect.right + nodeMargin / 2,
      firstNodeRect.center.dy,
    );
    final edgeEnd = Offset(
      secondNodeRect.left - nodeMargin / 2,
      secondNodeRect.center.dy,
    );
    canvas.drawLine(
      edgeStart,
      edgeEnd,
      Paint()
        ..color = Colors.red
        ..strokeWidth = 2.0,
    );
  }

  @override
  bool shouldRepaint(MyCustomPainter oldDelegate) {
    // Return true if any changes to your custom painting logic should trigger a repaint of the widget
    return true;
  }

  bool _draggingFirstNode = false;
  bool _draggingSecondNode = false;

  void _handleTouch(PointerEvent event) {
    if (event is PointerDownEvent) {
      if (Rect.fromCircle(
        center: start,
        radius: 25.0,
      ).contains(event.position)) {
        _draggingFirstNode = true;
      } else if (Rect.fromCircle(
        center: end,
        radius: 25.0,
      ).contains(event.position)) {
        _draggingSecondNode = true;
      }
    } else if (event is PointerUpEvent) {
      _draggingFirstNode = false;
      _draggingSecondNode = false;
    } else if (event is PointerMoveEvent) {
      if (_draggingFirstNode) {
        start = event.position;
        onUpdate(start, end);
      } else if (_draggingSecondNode) {
        end = event.position;
        onUpdate(start, end);
      }
    }
  }
}

class Node {
  final String id;
  final String label;
  final Offset position;
  final Size size;
  final List<Node> inputs;
  final List<Node> outputs;

  Node({
    required this.id,
    required this.label,
    required this.position,
    required this.size,
    required this.inputs,
    required this.outputs,
  });
}
