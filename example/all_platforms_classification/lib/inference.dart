export 'inference_stub.dart'
  if (dart.library.io) 'inference_native.dart'
  if (dart.library.html) 'inference_web.dart';