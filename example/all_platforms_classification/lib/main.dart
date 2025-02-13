import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lite_rt_for_flutter/lite_rt_for_flutter.dart';
import 'package:image/image.dart' as img;
import 'package:tuple/tuple.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TF lite on flutter web demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'TF lite on flutter web demo'),
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

  /// the tensorflow lite model
  Interpreter? interpreter;
  /// let the user pick images
  final ImagePicker picker = ImagePicker();
  /// the currently loaded image
  Uint8List? currentImage;

  List<Tuple2<String, double>> preds = [];

  List<String> labels = [];



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder(
          future: init(),
          builder: (context, snapshot) {

            if(interpreter == null) return Container();

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if(currentImage != null)
                  ...[
                    Image.memory(currentImage!),
                    SizedBox(height: 16,),
                    Text("This is ..."),
                    SizedBox(height: 8,),
                    ... [
                      for (int i = 0; i < preds.length; i++)
                        Text("${preds[i].item1}: ${preds[i].item2.toString().substring(0, 4)}")
                    ],
                    SizedBox(height: 16,),
                  ],
                OutlinedButton(
                  onPressed: pickImageButtonPressed,
                  child: Text("Pick an image"),
                ),
              ],
            );
          },
        )
      ),
    );
  }

  Future<bool> init() async {

    await initTfLite();
    labels = await loadLabels();

    return true;

  }

  /// Initializes the TF Lite runtime
  Future<bool> initTfLite() async {

    if(interpreter != null) return true;

    await initLiteRTFlutter();

    final buffer = (await rootBundle.load("assets/mobilenet_quant.tflite"))
      .buffer.asUint8List();
    
    interpreter = await Interpreter.fromBuffer(buffer);

    return true;

  }

  Future<List<String>> loadLabels() async {

    return (await rootBundle.loadString('assets/labels.txt')).split('\n');
  
  }

  /// Callback that is executed when the user pressed the "Pick an Image" button
  Future pickImageButtonPressed() async {
                
    // open image picker and try decoding it to bytes
    final image = await picker.pickImage(source: ImageSource.gallery);
    if(image == null) return;
    final imageBytes = (await image.readAsBytes());
    final decoded = img.decodeImage(imageBytes);
    if(decoded == null) return;

    // resize image
    int w = decoded.width; int h = decoded.height;
    final resized = img.copyResize(decoded,
      height: (w < h ? 224 : null),
      width : (w > h ? 224 : null),
    );
    
    // pad image
    final padded = img.copyExpandCanvas(
      resized, newWidth: 224, newHeight: 224,
      backgroundColor: img.ColorRgb8(0, 0, 0));

    // run inference
    final out = interpreter!.runForMultipleInputsWebJs(padded.getBytes());
      //shape: [1, 224, 224, 3],
      //type: tf_web.TFLiteDataType.int32
    final d = Uint8List.fromList(out.dataSync());

    // get 3 top predictions
    preds.clear();
    int maxScore = d.reduce((a, b) => a + b);
    for (var i = 0; i < d.length; i++) {
      if (d[i] != 0) {
        preds.add(Tuple2(labels[i], d[i].toDouble() / maxScore.toDouble()));
      }
    }
    preds.sort((a, b) => b.item2.compareTo(a.item2),);
    preds = preds.sublist(0, 3);

    // refresh ui with selected image and predictions
    setState(() { currentImage = img.encodePng(padded); });
  }
}
