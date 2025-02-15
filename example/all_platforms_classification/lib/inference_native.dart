import 'dart:typed_data';

import 'package:lite_rt_for_flutter/lite_rt_for_flutter.dart' as litert;


/// the tensorflow lite model
litert.Interpreter? interpreter;

Future initLiteRTFlutter() async {
  litert.initLiteRTFlutter();
}

Future loadModel(Uint8List buffer) async {
  interpreter = litert.Interpreter.fromBuffer(buffer);
}

Future runInference(Object inputs, List<List<int>> outputs) async {

  interpreter!.run(inputs, outputs);

  return outputs[0];

}