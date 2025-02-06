import 'package:flutter/services.dart';
import 'package:lite_rt_for_dart/lite_rt_for_dart.dart';



/// Adds flutter related utilities to the base interpreter class
extension FlutterInterpreter on Interpreter {

  /// Creates interpreter from a [assetName]
  ///
  /// Place your `.tflite` file in your assets folder.
  ///
  /// Example:
  ///
  /// ```dart
  /// final interpreter = await tfl.Interpreter.fromAsset('assets/your_model.tflite');
  /// ```
  static Future<Interpreter> fromAsset(String assetName,
      {InterpreterOptions? options}) async {
    Uint8List buffer = await _getBuffer(assetName);
    return Interpreter.fromBuffer(buffer, options: options);
  }

  /// Get byte buffer
  static Future<Uint8List> _getBuffer(String assetFileName) async {
    ByteData rawAssetFile = await rootBundle.load(assetFileName);
    final rawBytes = rawAssetFile.buffer.asUint8List();
    return rawBytes;
  }

}
