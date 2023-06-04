import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:genesis/libraries/designLibrary.dart' as design;

class LayeredGraphViewPageState extends State {
  int nodeNumber = 0;
  int edgeNumberFrom = 0;
  int edgeNumberTo = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomPaint(
      painter: BackgroundPaint(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 10,
          ),
          Wrap(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: design.mainColor,
                  borderRadius: design.level1BorderRadius,
                  boxShadow: [
                    BoxShadow(color: design.mainColor, spreadRadius: 1),
                  ],
                ),
                height: 50,
                width: 700,
                child: Row(
                  children: [
                    Container(
                      padding: design.level1Padding,
                      child: InkWell(
                        borderRadius: design.level2BorderRadius,
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                final node12 = Node.Id(nodeNumber);
                                var edge = graph.getNodeAtPosition(
                                    r.nextInt(graph.nodeCount()));
                                print(edge);
                                graph.addEdge(edge, node12);
                              });
                            },
                            child: Text('Add random')),
                      ),
                    ),
                    Container(
                      padding: design.level1Padding,
                      child: InkWell(
                        borderRadius: design.level2BorderRadius,
                        child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.grey[900],
                                    title: Text(
                                      'Add node to the system',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    content: Text(
                                      'Select the node number',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    actions: <Widget>[
                                      TextField(
                                        decoration: InputDecoration(
                                          hintText: 'Node number',
                                          fillColor: Colors.white,
                                          hintStyle:
                                              TextStyle(color: Colors.white),
                                        ),
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          nodeNumber = int.parse(value);
                                        },
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextButton(
                                        child: Text(
                                          'Add',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            final node12 = Node.Id(nodeNumber);
                                            graph.addNode(node12);
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text('Add node')),
                      ),
                    ),
                    Container(
                      padding: design.level1Padding,
                      child: InkWell(
                        borderRadius: design.level2BorderRadius,
                        child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.grey[900],
                                    title: Text(
                                      'Add Edge ',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    content: Text(
                                      'Select the node number',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    actions: <Widget>[
                                      TextField(
                                        decoration: InputDecoration(
                                          hintText: 'From',
                                          fillColor: Colors.white,
                                          hintStyle:
                                              TextStyle(color: Colors.white),
                                        ),
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          edgeNumberFrom = int.parse(value);
                                        },
                                      ),
                                      TextField(
                                        decoration: InputDecoration(
                                          hintText: 'To',
                                          fillColor: Colors.white,
                                          hintStyle:
                                              TextStyle(color: Colors.white),
                                        ),
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          edgeNumberTo = int.parse(value);
                                        },
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextButton(
                                        child: Text(
                                          'Add',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            graph.addEdge(
                                                Node.Id(edgeNumberFrom),
                                                Node.Id(edgeNumberTo));
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text('Add Edge')),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: InteractiveViewer(
                constrained: false,
                boundaryMargin: EdgeInsets.all(100),
                minScale: 0.0001,
                maxScale: 10.6,
                child: GraphView(
                  graph: graph,
                  algorithm: SugiyamaAlgorithm(builder),
                  paint: Paint()
                    ..color = Colors.green
                    ..strokeWidth = 2
                    ..style = PaintingStyle.fill
                    ..strokeCap = StrokeCap.round,
                  builder: (Node node) {
                    // I can decide what widget should be shown here based on the id
                    var a = node.key!.value as int?;
                    if (a == 1) {
                      return startWidget(a);
                    } else if (a == 1000) {
                      return endWidget(a);
                    } else {
                      return rectangleWidget(a);
                    }
                  },
                )),
          ),
        ],
      ),
    ));
  }

  Random r = Random();

  Widget rectangleWidget(int? a) {
    return Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(color: Colors.blue[100]!, spreadRadius: 1),
          ],
        ),
        child: Text('Node ${a}'));
  }

  Widget startWidget(int? a) {
    return Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(color: Colors.blue[100]!, spreadRadius: 1),
          ],
        ),
        child: Text('Input'));
  }

  Widget endWidget(int? a) {
    return Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(color: Colors.blue[100]!, spreadRadius: 1),
          ],
        ),
        child: Text('Output'));
  }

  final Graph graph = Graph();

  SugiyamaConfiguration builder = SugiyamaConfiguration()
    ..bendPointShape = CurvedBendPointShape(curveLength: 20);

  @override
  void initState() {
    super.initState();
    final node1 = Node.Id(1);
    final node3 = Node.Id(3);
    final node4 = Node.Id(4);
    final node5 = Node.Id(5);
    final node6 = Node.Id(6);
    final node1000 = Node.Id(1000);

    graph.addEdge(node1, node4);
    graph.addEdge(node1, node3);
    graph.addEdge(node3, node4);
    graph.addEdge(node3, node5);
    graph.addEdge(node5, node6);
    graph.addEdge(node6, node1000);
    graph.addEdge(node4, node1000);

    builder
      ..levelSeparation = (20)
      ..orientation = SugiyamaConfiguration.ORIENTATION_LEFT_RIGHT;
  }
}

class BackgroundPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    final paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Colors.grey;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 0.1;

    final heightLine = height ~/ 50; // your Horizontal line
    final widthLine = (width ~/ 100); // your Vertical line

    for (int i = 1; i < height; i++) {
      if (i % heightLine == 0) {
        Path linePath = Path();

        linePath
            .addRect(Rect.fromLTRB(0, i.toDouble(), width, (i + 2).toDouble()));
        canvas.drawPath(linePath, paint);
      }
    }
    for (int i = 1; i < width; i++) {
      if (i % widthLine == 0) {
        Path linePath = Path();
        linePath.addRect(
            Rect.fromLTRB(i.toDouble(), 0, (i + 2).toDouble(), height));
        canvas.drawPath(linePath, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
