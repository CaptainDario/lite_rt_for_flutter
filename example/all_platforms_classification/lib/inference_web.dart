import 'dart:typed_data';

import 'package:lite_rt_for_flutter/libs.dart';
import 'package:lite_rt_for_flutter_libs/lite_rt_for_flutter_libs.dart';



TFLiteModel? interpreter;

Future initLiteRTFlutter() async {

  String assetsPath = getLiteRTBaseLibraryPath();

  await TFLiteWeb.initialize(
    tfJsScriptUrl: "$assetsPath/tf-core.js",
    tfBackendScriptUrls: ["$assetsPath/tf-backend-cpu.js"],
    tfliteScriptUrl: "$assetsPath/tf-tflite.min.js",
  );

}

Future loadModel(Uint8List buffer) async {
  
  interpreter = await TFLiteModel.fromMemory(buffer);

}

Future runInference(Object inputs, Object outputs) async {

  final inputTensor = createTensor(inputs, shape: [1, 224, 224, 3]);

  final Tensor preds = await interpreter!.predict(inputTensor);

  return await preds.dataSync();

}