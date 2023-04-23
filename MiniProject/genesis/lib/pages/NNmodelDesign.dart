import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:genesis/libraries/designLibrary.dart' as design;

class NNModelSystemScreenState extends State {
  List<Widget> nodeWidgets = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
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
                            nodeWidgets.add(Node());
                          });
                        },
                        child: Icon(Icons.add)),
                  ),
                ),
              ],
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: design.level1Padding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Container(
                            child: Text("Input Layer"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width / 2,
                    child: ListView(
                      children: List.generate(
                          nodeWidgets.length, (index) => nodeWidgets[index]),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Container(
                            child: Text("Output Layer"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

class Node extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      color: Colors.red,
    );
  }
}
