import 'dart:io';

import 'package:flutter/services.dart';

import 'package:lite_rt_for_dart/src/bindings/bindings.dart';



/// Get the `DynamicLibrary` of this plugin, ie. the base tf lite runtime
String getLiteRTBaseLibraryPath(){

  String libTfLitePath;

  if (Platform.isAndroid) {
    libTfLitePath = 'libtensorflowlite_jni.so';
  }
  else if (Platform.isIOS) {
    libTfLitePath = shouldUseDynamicLibraryProcess;
  }
  else if (Platform.isMacOS) {
    libTfLitePath = "libtensorflowlite_c.dylib";
  }
  else if (Platform.isLinux) {
    // TODO
    libTfLitePath = 'libtflite_c.so';
  }
  else if (Platform.isWindows) {
    // TODO
    libTfLitePath = 'libtflite_c.dll';
  }
  // TODO web
  else {
    throw PlatformException(code: "Platform unsupported");
  }

  return libTfLitePath;

}

/// Get the `DynamicLibrary` that contain the GPU delegate
String getLiteRTGpuDelegateLibraryPath(){

  String libTfLitePath = "";

  if (Platform.isAndroid) {
    libTfLitePath = "libtensorflowlite_gpu_jni.so";
  }
  else if (Platform.isIOS) {
    libTfLitePath = shouldUseDynamicLibraryProcess;
  }
  else if (Platform.isMacOS) {
    libTfLitePath = "libtensorflowlite_gpu_delegate_c.dylib";
  }
  else if (Platform.isLinux) {
    // TODO
  }
  else if (Platform.isWindows) {
    // TODO
  }
  // TODO web
  else {
    throw PlatformException(code: "Platform unsupported");
  }

  return libTfLitePath;

}

/// Get the `DynamicLibrary` that contains the CoreML delegate
String getLiteRTCoreMLDelegateLibraryPath(){

  String libTfLitePath = "";

  if (Platform.isAndroid) {
    // TODO
  }
  else if (Platform.isIOS) {
    libTfLitePath = shouldUseDynamicLibraryProcess;
  }
  else if (Platform.isMacOS) {
    // TODO
  }
  else if (Platform.isLinux) {
    // TODO
  }
  else if (Platform.isWindows) {
    // TODO
  }
  // TODO web
  else {
    throw PlatformException(code: "Platform unsupported");
  }

  return libTfLitePath;

}

/// Get the `DynamicLibrary` that contains the Flex delegate
String getLiteRTFlexDelegateLibraryPath(){

  String libTfLitePath = "";

  if (Platform.isAndroid) {
    // TODO
    //libTfLitePath = '${libTfLitePath}_jni.so';
  }
  else if (Platform.isIOS) {
    libTfLitePath = shouldUseDynamicLibraryProcess;
  }
  else if (Platform.isMacOS) {
    // TODO
  }
  else if (Platform.isLinux) {
    // TODO
  }
  else if (Platform.isWindows) {
    // TODO
  }
  // TODO web
  else {
    throw PlatformException(code: "Platform unsupported");
  }

  return libTfLitePath;

}