export 'package:lite_rt_for_dart/lite_rt_for_dart.dart';

import 'package:lite_rt_for_dart/lite_rt_for_dart.dart';
import 'package:lite_rt_for_flutter/libs.dart';



/// Initializes the LiteRT runtime using the libs included in the
/// lite_rt_for_flutter_libs* packages.
/// 
/// See `initLiteRT` for details on `loadLibs`
void initLiteRTFlutter({bool loadLibs = false}){

  initLiteRT(getLiteRTBaseLibraryPath(),
    // TODO gpuDelegatelibraryPath: gpuDelegatelibraryPath,
    loadLibs: loadLibs);

}