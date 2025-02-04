
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

The only real difference between this (except some convenience methods) and the standalone dart package is that LiteRT binaries can be included using the additional libs packages:

|        |   Android  |     iOS    |   Windows  |    MacOS   |    Linux   |     Web    | Web --wasm |
|--------|:----------:|:----------:|:----------:|:----------:|:----------:|:----------:|:----------:|
|        | arm \| x86 | arm \| x86 | arm \| x86 | arm \| x86 | arm \| x86 | arm \| x86 |            |
| Base   |   ✅ \| ✅   |   🚧 \| 🚧   |   🚧 \| 🚧   |   🚧 \| 🚧   |   🚧 \| 🚧   |   🚧 \| 🚧   |      🚧     |
| GPU    |   📋 \| 📋   |   📋 \| 📋   |   ❌ \| ❌   |   ❌ \| ❌   |   ❌ \| ❌   |   ❌ \| ❌   |   ❌ \| ❌   |
| CoreML |   📋 \| 📋   |   📋 \| 📋   |   ❌ \| ❌   |   ❌ \| ❌   |   ❌ \| ❌   |   ❌ \| ❌   |   ❌ \| ❌   |
| Flex   |   📋 \| 📋   |   📋 \| 📋   |   ❌ \| ❌   |   ❌ \| ❌   |   ❌ \| ❌   |   ❌ \| ❌   |   ❌ \| ❌   |

✅ - supported ; 🚧 - working on it ; 📋 planned ; ⛔️ not planned ; ❌ - not supported by LiteRT

## Setup

In the dependency section of `pubspec.yaml` file, add `lite_rt_for_flutter: <your version>`

```yaml
dependencies:
  # The binding between Flutter/Dart and native code
  lite_rt_for_flutter:
    git:
      url:  https://github.com/CaptainDario/lite_rt_for_flutter
      ref: <THE_VERSION_YOU_WANT>
```

Additionally, you need at least the base LiteRT, choose the packages you need from below

```yaml
dependencies:

  ...

  # Includes the Base LiteRT runtime with XNNPack delegate
  lite_rt_for_flutter_libs:
    git:
      url:  https://github.com/CaptainDario/lite_rt_for_flutter_libs
      path: lite_rt_for_flutter_libs
      ref: <THE_VERSION_YOU_WANT>
```

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
