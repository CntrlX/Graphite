import 'dart:convert';
import 'dart:html' as html;

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: TextButton(
              child: Text("download"),
              onPressed: () {
                final text = 'this is the text file';

                // prepare
                final bytes = utf8.encode(text);
                final blob = html.Blob([bytes]);
                final url = html.Url.createObjectUrlFromBlob(blob);
                final anchor =
                    html.document.createElement('a') as html.AnchorElement
                      ..href = url
                      ..style.display = 'none'
                      ..download = 'some_name.txt';
                html.document.body!.children.add(anchor);

                // download
                anchor.click();

                // cleanup
                html.document.body!.children.remove(anchor);
                html.Url.revokeObjectUrl(url);
              }),
        ),
      ),
    );
  }
}
