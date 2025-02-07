import 'dart:typed_data';

import 'package:lite_rt_for_flutter/lite_rt_for_flutter.dart';
import 'package:lite_rt_for_flutter/utils.dart';



/// Extension on `IsolateInterpreter` that adds flutter specific methods
extension FlutterIsolateInterpreter on IsolateInterpreter{

  /// Creates interpreter from a [assetName]
  ///
  /// Place your `.tflite` file in your assets folder.
  ///
  /// Example:
  ///
  /// ```dart
  /// final interpreter = await FlutterInterpreter.fromAsset('assets/your_model.tflite');
  /// ```
  static Future<FlutterIsolateInterpreter> createFromAsset(String assetName,
      {InterpreterOptions? options, InterpreterOptions options}) async {
    Uint8List buffer = await getBufferFromAsset(assetName);
    return await IsolateInterpreter.createFromBuffer(buffer, options: options);
  }

}