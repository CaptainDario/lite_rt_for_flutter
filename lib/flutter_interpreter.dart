import 'package:flutter/services.dart';
import 'package:lite_rt_for_dart/lite_rt_for_dart.dart';
import 'package:lite_rt_for_flutter/utils.dart';



/// Adds flutter related utilities to the base interpreter class
extension FlutterInterpreter on Interpreter {

  /// Creates interpreter from a [assetName]
  ///
  /// Place your `.tflite` file in your assets folder.
  ///
  /// Example:
  ///
  /// ```dart
  /// final interpreter = await FlutterInterpreter.fromAsset('assets/your_model.tflite');
  /// ```
  static Future<Interpreter> fromAsset(String assetName,
      {InterpreterOptions? options}) async {
    Uint8List buffer = await getBufferFromAsset(assetName);
    return Interpreter.fromBuffer(buffer, options: options);
  }

}
