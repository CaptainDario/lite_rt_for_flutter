import 'dart:typed_data';

import 'package:lite_rt_for_flutter/lite_rt_for_flutter.dart' as litert;


/// the tensorflow lite model
litert.Interpreter? interpreter;

Future initLiteRTFlutter() async {
  litert.initLiteRTFlutter();
}

Future loadModel(Uint8List buffer) async {

  litert.InterpreterOptions io = litert.InterpreterOptions();
  
  // ios
  io.addDelegate(litert.GpuDelegate());
  //io.addDelegate(litert.CoreMlDelegate(options: litert.CoreMlDelegateOptions(coremlVersion: 3)));

  //io.useNnApiForAndroid = true;

  interpreter = litert.Interpreter.fromBuffer(buffer);

}

Future runInference(Object inputs, List<List<int>> outputs) async {

  interpreter!.run(inputs, outputs);

  print((interpreter!.lastNativeInferenceDurationMicroSeconds).toInt());

  return outputs[0];

}