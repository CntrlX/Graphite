import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

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
              width: 100,
              child: TextFormField(
                initialValue: builder.nodeSeparation.toString(),
                decoration: InputDecoration(labelText: 'Node Separation'),
                onChanged: (text) {
                  builder.nodeSeparation = int.tryParse(text) ?? 100;
                  this.setState(() {});
                },
              ),
            ),
            Container(
              width: 100,
              child: TextFormField(
                initialValue: builder.levelSeparation.toString(),
                decoration: InputDecoration(labelText: 'Level Separation'),
                onChanged: (text) {
                  builder.levelSeparation = int.tryParse(text) ?? 100;
                  this.setState(() {});
                },
              ),
            ),
            Container(
              width: 100,
              child: TextFormField(
                initialValue: builder.orientation.toString(),
                decoration: InputDecoration(labelText: 'Orientation'),
                onChanged: (text) {
                  builder.orientation = int.tryParse(text) ?? 100;
                  this.setState(() {});
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final node12 = Node.Id(r.nextInt(100));
                var edge =
                    graph.getNodeAtPosition(r.nextInt(graph.nodeCount()));
                print(edge);
                graph.addEdge(edge, node12);
                setState(() {});
              },
              child: Text('Add'),
            )
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
