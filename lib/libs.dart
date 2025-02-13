import 'package:universal_io/io.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:flutter/foundation.dart';


/// if a library path is set to this value, the `DynamicLibrary` shoudl be
/// loaded with `DynamicLibrary.process()`
String shouldUseDynamicLibraryProcess = "DynamicLibrary.process();";
/// Message to throw when this platform does not support this lib
String unsupportedPlatform = "Platform ${UniversalPlatform.operatingSystem} is not supported by";

/// Get the `DynamicLibrary` of this plugin, ie. the base tf lite runtime
String getLiteRTBaseLibraryPath(){

  String libTfLitePath = "";

  if (UniversalPlatform.isWeb){
    libTfLitePath =
      'assets/packages/lite_rt_for_flutter_libs_web_tfjs_tflite/web/assets/tflite/';
  }
  else if (UniversalPlatform.isAndroid) {
    libTfLitePath = 'libtensorflowlite_jni.so';
  }
  else if (UniversalPlatform.isIOS) {
    libTfLitePath = shouldUseDynamicLibraryProcess;
  }
  else if (UniversalPlatform.isMacOS) {
    libTfLitePath = "libtensorflowlite_c.dylib";
  }
  else if (UniversalPlatform.isLinux) {
    // TODO
    libTfLitePath = 'libtflite_c.so';
  }
  else if (UniversalPlatform.isWindows) {
    // TODO
    libTfLitePath = 'libtflite_c.dll';
  }

  if(libTfLitePath == ""){
    debugPrint("LiteRT is not supported on this platform");
  }

  return libTfLitePath;

}

/// Get the `DynamicLibrary` that contain the GPU delegate
String getLiteRTGpuDelegateLibraryPath(){

  String libTfLitePath = "";

  if (UniversalPlatform.isAndroid) {
    libTfLitePath = "libtensorflowlite_gpu_jni.so";
  }
  else if (UniversalPlatform.isIOS) {
    libTfLitePath = shouldUseDynamicLibraryProcess;
  }
  else if (UniversalPlatform.isMacOS) {
    libTfLitePath = "libtensorflowlite_gpu_delegate_c.dylib";
  }
  else if (UniversalPlatform.isLinux) {
    // TODO Linux
  }
  else if (UniversalPlatform.isWindows) {
    // TODO Windows
  }
  
  if(libTfLitePath == ""){
    debugPrint("$unsupportedPlatform the GPU delegate");
  }

  return libTfLitePath;

}

/// Get the `DynamicLibrary` that contains the CoreML delegate
String getLiteRTCoreMLDelegateLibraryPath(){

  String libTfLitePath = "";

  if (UniversalPlatform.isIOS) {
    libTfLitePath = shouldUseDynamicLibraryProcess;
  }
  else if (UniversalPlatform.isMacOS) {
    debugPrint("MacOS could be supported, upvote this issue if you are interested: https://github.com/google-ai-edge/LiteRT/issues/800");
  }

  if(libTfLitePath == ""){
    debugPrint("$unsupportedPlatform the CoreML delegate");
  }
  return libTfLitePath;

}

/// Get the `DynamicLibrary` that contains the Flex delegate
String getLiteRTFlexDelegateLibraryPath(){

  String libTfLitePath = "";

  if (UniversalPlatform.isAndroid) {
    // TODO
    //libTfLitePath = 'libtensorflowlite_flex_jni.so';
  }
  else if (UniversalPlatform.isIOS) {
    libTfLitePath = shouldUseDynamicLibraryProcess;
  }
  else if (UniversalPlatform.isMacOS) {
    // TODO
  }
  else if (UniversalPlatform.isLinux) {
    // TODO
  }
  else if (UniversalPlatform.isWindows) {
    // TODO
  }

  if(libTfLitePath == ""){
    debugPrint("$unsupportedPlatform the Flex delegate");
  }

  return libTfLitePath;

}