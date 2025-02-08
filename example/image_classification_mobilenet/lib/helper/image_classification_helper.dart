/*
 * Copyright 2023 The TensorFlow Authors. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *             http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart';
import 'package:lite_rt_for_flutter/flutter_interpreter.dart';
import 'package:lite_rt_for_flutter/flutter_isolate_interpreter.dart';
import 'package:lite_rt_for_flutter/lite_rt_for_flutter.dart';

import 'inference.dart';

class ImageClassificationHelper {
  static const modelPath = 'assets/models/mobilenet_quant.tflite';
  static const labelsPath = 'assets/models/labels.txt';

  late final IsolateInterpreter interpreter;
  late final List<String> labels;
  late Tensor inputTensor;
  late Tensor outputTensor;

  int? inferenceTime;

  // Load model
  Future<void> _loadModel() async {
    var options = InterpreterOptions();

    // Use XNNPACK Delegate
    if (Platform.isAndroid) {
      
      //final del = XNNPackDelegate(options: XNNPackDelegateOptions(numThreads: 2));
      final del = GpuDelegateV2();
      
      options.addDelegate(del);
    }

    // Use Metal or CoreML Delegate
    if (Platform.isIOS || Platform.isMacOS) {

      //final delegate = GpuDelegate(options: GpuDelegateOptions());
      final delegate = CoreMlDelegate(options: CoreMlDelegateOptions());
      options.addDelegate(delegate);
    }

    // Load model from assets
    interpreter = await FlutterIsolateInterpreter.createFromAsset(modelPath,
      options: options);

    // Get tensor input shape [1, 224, 224, 3]
    inputTensor = (await interpreter.getInputTensors()).first;
    // Get tensor output shape [1, 1001]
    outputTensor = (await interpreter.getOutputTensors()).first;

    log('Interpreter loaded successfully');
  }

  // Load labels from assets
  Future<void> _loadLabels() async {
    final labelTxt = await rootBundle.loadString(labelsPath);
    labels = labelTxt.split('\n');
  }

  Future<void> initHelper() async {
    _loadLabels();
    _loadModel();
  }

  Future<Map<String, double>> _inference(InferenceModel inferenceModel) async {
      
    final results = runInference(inferenceModel);
    return results;

  }

  // inference camera frame
  Future<Map<String, double>> inferenceCameraFrame(
      CameraImage cameraImage) async {
    var isolateModel = InferenceModel(cameraImage, null, interpreter,
      labels, inputTensor.shape, outputTensor.shape);
    return _inference(isolateModel);
  }

  // inference still image
  Future<Map<String, double>> inferenceImage(Image image) async {
    var isolateModel = InferenceModel(null, image, interpreter,
      labels, inputTensor.shape, outputTensor.shape);
    return _inference(isolateModel);
  }

}
