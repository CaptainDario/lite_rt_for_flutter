
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

This plugin provides bindings for LiteRT (formerly TF lite) for Flutter.
[Try it out in the browser!](https://captaindario.github.io/lite_rt_for_flutter/)

The only real difference between this (except some convenience methods) and the standalone dart package is that LiteRT binaries can be included using the additional libs packages:

|        |   Android  |     iOS    |   Windows  |    MacOS   |    Linux   |     Web    |
|--------|:----------:|:----------:|:----------:|:----------:|:----------:|:----------:|
|        |    arm     |     arm    | arm \| x86 | arm \| x86 | arm \| x86 | js \| wasm |
| Base   |     ✅     |   ✅   | [ℹ️](https://github.com/CaptainDario/lite_rt_for_flutter_libs/issues/1) \| ✅ |   ✅ \| ✅  |   ✅ \| ✅  |   [ℹ️](#web-support) \| [ℹ️](https://github.com/CaptainDario/lite_rt_for_flutter_libs/issues/1)   |
| GPU    |     ✅     |   ✅   |   ❌ \| ❌   |   ❌ \| ❌   |   ❌ \| ❌   |   ❌ \| ❌   |
| CoreML |     ⛔     |   ✅   |   ⛔ \| ⛔   | [ℹ️](https://github.com/CaptainDario/lite_rt_for_flutter_libs/issues/2) |   ⛔ \| ⛔   |   ⛔ \| ⛔   |
| Flex   |     ✅     |   ✅   |   ❌ \| ❌   |   ❌ \| ❌   |   ❌ \| ❌   |   ❌ \| ❌   |

✅ - supported ; 🚧 - working on it ; 📋 planned ; ⛔ - not applicable ; ❌ - not supported by LiteRT ; ℹ️ - click to learn more

## Setup

In the dependency section of `pubspec.yaml` file, add `lite_rt_for_flutter: <your version>`

```yaml
dependencies:
  # The binding between Flutter/Dart and native code
  lite_rt_for_flutter:
    version: <THE_VERSION_YOU_WANT>

  # Additionally, you need the base LiteRT libraries (includes XNNPack delegate)
  lite_rt_for_flutter_libs:
    version: <THE_VERSION_YOU_WANT>
  # optionally you can set specific versions per platform
  lite_rt_for_flutter_libs_{android|macos|...}:
    version: <THE_VERSION_YOU_WANT>
```

Finally, run some ML on-device!

```dart
import 'package:liter_rt_for_flutter/liter_rt_for_flutter.dart';

// IMPORTANT: initialize the plugin
initLiteRTFlutter()

// Load a model from asset
final interpreter = await FlutterInterpreter.fromAsset('asset/path/to/your/model.tflite');

```

You can learn more about how to use this library here:

* [the dart package](https://github.com/CaptainDario/lite_rt_for_dart?tab=readme-ov-file#example).
* For som complete examples, see the [examples folder](./example/)

## What about delegates?

Additional delegate libraries can be included for supported platforms.
See the above table for which delegate supports which platform.

```yaml
dependencies:
  # Include the CoreML delegate
  lite_rt_for_flutter_libs_coreml:
    version: <THE_VERSION_YOU_WANT>
  # Include the flex delegate
  lite_rt_for_flutter_libs_flex:
    version: <THE_VERSION_YOU_WANT>
  # Include the gpu delegate
  lite_rt_for_flutter_libs_gpu:
    version: <THE_VERSION_YOU_WANT>
```

## Web support

This library does NOT directly support web.
However, using the following hacky approach, web support can be achieved the [tflit web package](https://pub.dev/packages/tflite_web).
Under the hood it uses tfjs' tf lite support using webassembly.

Binaries can be included using

```yaml
dependencies:
  # includes xnnpack delegate
  lite_rt_for_flutter_libs_web:
    version: 0.0.1-alpha10
```

Now you need to define inference based on native / web, for an example see [example/all_platforms_classification].

## I want to use my own libs

Sure thing! See the [dart package](https://github.com/CaptainDario/lite_rt_for_dart) to use any library.
