import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:genesis/libraries/designLibrary.dart' as design;

class LayeredGraphViewPageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
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
                              final node12 = Node.Id(r.nextInt(100));
                              var edge = graph.getNodeAtPosition(
                                  r.nextInt(graph.nodeCount()));
                              print(edge);
                              graph.addEdge(edge, node12);
                            });
                          },
                          child: Icon(Icons.add)),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
                  ..strokeWidth = 1
                  ..style = PaintingStyle.stroke
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
