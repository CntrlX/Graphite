import 'package:flutter/material.dart';
import 'package:genesis/pages/NNmodelDesign.dart';
import 'package:genesis/pages/NNmodelVisual.dart';
import 'pages/NNmodelSystem.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: nnModelViewPageClass(),
      );
}

class nnModelViewPageClass extends StatefulWidget {
  @override
  // nnModelViewPage createState() => nnModelViewPage();
  LayeredGraphViewPageState createState() => LayeredGraphViewPageState();
  // MyCustomWidget createState() => MyCustomWidget();
  // NNModelSystemScreenState createState() => NNModelSystemScreenState();
}
