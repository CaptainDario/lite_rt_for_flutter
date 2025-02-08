import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lite_rt_for_flutter/flutter_interpreter.dart';
import 'package:lite_rt_for_flutter/lite_rt_for_flutter.dart';
import 'package:lite_rt_for_flutter/utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  late Interpreter interpreter;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> init() async {
    initLiteRTFlutter();
    ByteData rawAssetFile = await rootBundle.load("select_ops_model/converted_model.tflite");
    final b = rawAssetFile.buffer.asUint8List();
    InterpreterOptions o = InterpreterOptions();
    o.addDelegate(XNNPackDelegate());
    interpreter = Interpreter.fromBuffer(b);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: init(),
        builder: (context, snapshot) {
          if(!snapshot.hasData) return Container();
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Press the button to check that there is no exception',
                ),
              ],
            ),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => interpreter.invoke(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
