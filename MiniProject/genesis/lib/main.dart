import 'package:flutter/material.dart';
import 'package:genesis/pages/NNmodelDesign.dart';
import 'package:genesis/pages/NNmodelVisual.dart';
import 'package:genesis/pages/login.dart';
import 'pages/NNmodelSystem.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyAV8ed1n73-dGIa7krpZ0eCOhv4J1Uu718",
          appId: "1:926709981503:web:249359d069915e01e2f38a",
          messagingSenderId: "926709981503",
          projectId: "genesis-82adf"));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: nnModelViewPageClass(),
        routes: {
          NNmodelSystem.route: (context) => NNmodelSystem(),
        },
      );
}

class nnModelViewPageClass extends StatefulWidget {
  @override
  // nnModelViewPage createState() => nnModelViewPage();
  // LayeredGraphViewPageState createState() => LayeredGraphViewPageState();
  LoginState createState() => LoginState();
  // MyCustomWidget createState() => MyCustomWidget();
  // NNModelSystemScreenState createState() => NNModelSystemScreenState();
}

class NNmodelSystem extends StatefulWidget {
  static String route = '/NNmodelSystem';

  const NNmodelSystem({super.key});

  @override
  LayeredGraphViewPageState createState() => LayeredGraphViewPageState();
}
