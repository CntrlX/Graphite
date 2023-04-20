import 'dart:math';

import 'package:flutter/material.dart';

import 'package:graphview/GraphView.dart';
import 'NNmodelSystem.dart';

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
  nnModelViewPage createState() => nnModelViewPage();
}
