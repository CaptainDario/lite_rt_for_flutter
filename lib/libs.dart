import 'dart:ffi';
import 'dart:io';

import 'package:flutter/services.dart';

import 'package:lite_rt_for_dart/src/bindings/bindings.dart';
import 'package:lite_rt_for_dart/src/bindings/tensorflow_lite_bindings_generated.dart';



/// Get the `DynamicLibrary` of this plugin, ie. the base tf lite runtime
String getLiteRTBaseLibraryPath(){

  String libTfLitePath = "libtensorflowlite";

  if (Platform.isAndroid) {
    libTfLitePath = '${libTfLitePath}_jni.so';
  }
  else if (Platform.isIOS) {
    libTfLitePath = shouldUseDynamicLibraryProcess;
  }
  else if (Platform.isMacOS) {
    //if(Abi.current() == Abi.macosArm64) libName += "arm64";
    //else if(Abi.current() == Abi.macosArm64) libName += "x86";
    
    libTfLitePath = "${libTfLitePath}_c.dylib";
    print(libTfLitePath);
  }
  else if (Platform.isLinux) {
    // TODO
    //tfLiteLib = DynamicLibrary.open('libtflite_c.so');
  }
  else if (Platform.isWindows) {
    // TODO
    //tfLiteLib = DynamicLibrary.open('libtflite_c.dll');
  }
  // TODO web
  else {
    throw PlatformException(code: "Platform unsupported");
  }

  return libTfLitePath;

}