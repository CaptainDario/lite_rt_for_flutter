import 'dart:typed_data';

import 'package:flutter/services.dart';



/// Get byte buffer
Future<Uint8List> getBufferFromAsset(String assetFileName) async {
  ByteData rawAssetFile = await rootBundle.load(assetFileName);
  final rawBytes = rawAssetFile.buffer.asUint8List();
  return rawBytes;
}