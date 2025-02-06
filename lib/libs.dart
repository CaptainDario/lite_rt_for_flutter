import 'dart:ffi';
import 'dart:io';

import 'package:flutter/services.dart';



/// Get the `DynamicLibrary` of this plugin, ie. the base tf lite runtime
String getLiteRTBaseLibraryPath(){

  String libTfLitePath = "libtensorflowlite_c";

  if (Platform.isAndroid) {
    // TODO
    //tfLiteLib = DynamicLibrary.open('libtensorflowlite_jni.so');
  }
  else if (Platform.isIOS) {
    // TODO
    //tfLiteLib = DynamicLibrary.process();
  }
  else if (Platform.isMacOS) {
    //if(Abi.current() == Abi.macosArm64) libName += "arm64";
    //else if(Abi.current() == Abi.macosArm64) libName += "x86";
    
    libTfLitePath = "$libTfLitePath.dylib";
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