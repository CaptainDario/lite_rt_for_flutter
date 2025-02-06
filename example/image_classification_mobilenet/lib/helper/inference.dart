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

import 'dart:io';
import 'dart:isolate';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as image_lib;
import 'package:image_classification_mobilenet/image_utils.dart';
import 'package:lite_rt_for_flutter/lite_rt_for_flutter.dart';

Future<Map<String, double>> runInference(InferenceModel isolateModel) async {

  image_lib.Image? img;
  if (isolateModel.isCameraFrame()) {
    img = ImageUtils.convertCameraImage(isolateModel.cameraImage!);
  } else {
    img = isolateModel.image;
  }

  // resize original image to match model shape.
  image_lib.Image imageInput = image_lib.copyResize(
    img!,
    width: isolateModel.inputShape[1],
    height: isolateModel.inputShape[2],
  );

  if (Platform.isAndroid && isolateModel.isCameraFrame()) {
    imageInput = image_lib.copyRotate(imageInput, angle: 90);
  }

  final imageMatrix = List.generate(
    imageInput.height,
    (y) => List.generate(
      imageInput.width,
      (x) {
        final pixel = imageInput.getPixel(x, y);
        return [pixel.r, pixel.g, pixel.b];
      },
    ),
  );

  // Set tensor input [1, 224, 224, 3]
  final input = [imageMatrix];
  // Set tensor output [1, 1001]
  final output = [List<int>.filled(isolateModel.outputShape[1], 0)];
  // inference
  final result = List<int>.from(
    (await isolateModel.interpreter.run(input, output)).first);
  // Get first output tensor
  //final result = output.first;
  int maxScore = result.reduce((a, b) => a + b);
  // Set classification map {label: points}
  var classification = <String, double>{};
  for (var i = 0; i < result.length; i++) {
    if (result[i] != 0) {
      // Set label: points
      classification[isolateModel.labels[i]] =
          result[i].toDouble() / maxScore.toDouble();
    }
  }
  return classification;

}

class InferenceModel {

  CameraImage? cameraImage;
  image_lib.Image? image;
  List<String> labels;
  List<int> inputShape;
  List<int> outputShape;
  IsolateInterpreter interpreter;
  late SendPort responsePort;

  InferenceModel(this.cameraImage, this.image, this.interpreter,
      this.labels, this.inputShape, this.outputShape);

  // check if it is camera frame or still image
  bool isCameraFrame() {
    return cameraImage != null;
  }
}
