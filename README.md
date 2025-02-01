
<p align="center">
    <br>
    <img src="./.github/readme/lite_rt_for_flutter.jpg"/>
    </br>
</p>

**IMPORTANT, READ THIS BEFORE USING THIS PLUGIN!**
* **This is NOT an official implementation, [Google's official plugin is here](https://pub.dev/packages/tflite_flutter)**
  * For proper support please use that plugin
* **I created this plugin to use in my own applications as I encountered various difficulties with the official plugin.**
  * Therefore, the main use case is that it works in my own applications, but it may be useful for others, which is why I opened sourced it.

## LiteRT (TF Lite) for Flutter

This plugin provides bindings for LiteRT (formerly TF lite) for standalone Flutter.

The only real difference between this (except some convenience methods) and the standalone dart package is that LiteRT binaries can be included using the additioal libs packages:

* [lite_rt_for_flutter_libs](https://github.com/CaptainDario/lite_rt_for_flutter_libs/)
  * Includes the base LiteRT runtime with XNNPack delegate

The next things I will work on in order

1. GPU coming soon
2. CoreML coming soon
3. Web coming soon
4. Flex Ops (might come if I find some time)

## Setup

In the dependency section of `pubspec.yaml` file, add `lite_rt_for_flutter: <your version>`

```dart
import 'package:liter_rt_for_flutter/liter_rt_for_flutter.dart';

// IMPORTANT: initialize the plugin
initLiteRTFlutter()

// Load a model from asset
final interpreter = await Interpreter.fromAsset('asset/path/to/your/model.tflite');

``` 

How to use the library further, see [the dart package](https://github.com/CaptainDario/lite_rt_for_dart?tab=readme-ov-file#example).
For a full example see the [examples folder](./example/)

## I want to use my own libs

Sure thing! See the [dart package](https://github.com/CaptainDario/lite_rt_for_dart) to use any library. 
