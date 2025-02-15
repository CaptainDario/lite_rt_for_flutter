/// This file defines the shared interface between the native and web
/// implementation
import 'dart:typed_data';


/// the tensorflow lite model
dynamic? interpreter;

Future initLiteRTFlutter() async {
  throw Exception("Not implemented");
}

Future loadModel(Uint8List buffer) async {
  throw Exception("Not implemented");
}

Future runInference(Object inputs, Object outputs) async {

}