'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "553c6ff1435f5d30aa5e97a46a919444",
"version.json": "5306abd22f10d6e56bed65ae1397d898",
"index.html": "ae6d4612eb18da64675784cf0b31e21a",
"/": "ae6d4612eb18da64675784cf0b31e21a",
"main.dart.js": "67ffe96c4d9663190df4837fa695da70",
"flutter.js": "4b2350e14c6650ba82871f60906437ea",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "0ef16220b1e0f81f4f04c013344ba3ff",
"assets/AssetManifest.json": "a30f10fff7b2b6399833132ed7af8092",
"assets/NOTICES": "f7e73942baa63cdafe3c5dc12976195d",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "dbcb5285c2351fca5f7265fa52a938b9",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/packages/lite_rt_for_flutter_libs_web_tfjs_tflite/web/assets/tflite/tflite_web_api_cc_threaded.wasm": "7b024d51a041de73a4d1b26e0473cd02",
"assets/packages/lite_rt_for_flutter_libs_web_tfjs_tflite/web/assets/tflite/tflite_web_api_cc_threaded.worker.js": "44431688ab49688f68a87c8921413622",
"assets/packages/lite_rt_for_flutter_libs_web_tfjs_tflite/web/assets/tflite/tflite_web_api_cc_threaded.js": "e7a1d0c9238d3b42176f8d40932f7c71",
"assets/packages/lite_rt_for_flutter_libs_web_tfjs_tflite/web/assets/tflite/tflite_web_api_cc_simd_threaded.js": "13302c4bdd373dee5d0a96c2c18780d8",
"assets/packages/lite_rt_for_flutter_libs_web_tfjs_tflite/web/assets/tflite/tflite_web_api_cc.js": "51bf9b537ac8e42835390738e1fe5923",
"assets/packages/lite_rt_for_flutter_libs_web_tfjs_tflite/web/assets/tflite/tf-backend-cpu.js": "158bfd19176baa69fa17452be0514a47",
"assets/packages/lite_rt_for_flutter_libs_web_tfjs_tflite/web/assets/tflite/tf-core.js": "332573fae9dcff5f735cfee9354d767a",
"assets/packages/lite_rt_for_flutter_libs_web_tfjs_tflite/web/assets/tflite/tflite_web_api_cc.wasm": "00d72420a913989f016f61d15975da6d",
"assets/packages/lite_rt_for_flutter_libs_web_tfjs_tflite/web/assets/tflite/tflite_web_api_cc_simd_threaded.worker.js": "44431688ab49688f68a87c8921413622",
"assets/packages/lite_rt_for_flutter_libs_web_tfjs_tflite/web/assets/tflite/tflite_web_api_cc_simd_threaded.wasm": "f06a0c782821c4106e0b1aca8c176aa2",
"assets/packages/lite_rt_for_flutter_libs_web_tfjs_tflite/web/assets/tflite/tflite_web_api_cc_simd.wasm": "6ef1acb772648ab13dfe78e056170d7f",
"assets/packages/lite_rt_for_flutter_libs_web_tfjs_tflite/web/assets/tflite/tf-tflite.min.js": "55c66045fb9b091beb836d48d9582175",
"assets/packages/lite_rt_for_flutter_libs_web_tfjs_tflite/web/assets/tflite/tflite_web_api_cc_simd.js": "975c51703a25dc12db6a76c6bd183c46",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "99a9cc31633755013249bc2556e28502",
"assets/fonts/MaterialIcons-Regular.otf": "0db35ae7a415370b89e807027510caf0",
"assets/assets/labels.txt": "295d81f0039772b0c909237eb803b42d",
"assets/assets/mobilenet_quant.tflite": "6cf77d65e1b5ef9a2256e71005952317",
"canvaskit/skwasm.js": "ac0f73826b925320a1e9b0d3fd7da61c",
"canvaskit/skwasm.js.symbols": "96263e00e3c9bd9cd878ead867c04f3c",
"canvaskit/canvaskit.js.symbols": "efc2cd87d1ff6c586b7d4c7083063a40",
"canvaskit/skwasm.wasm": "828c26a0b1cc8eb1adacbdd0c5e8bcfa",
"canvaskit/chromium/canvaskit.js.symbols": "e115ddcfad5f5b98a90e389433606502",
"canvaskit/chromium/canvaskit.js": "b7ba6d908089f706772b2007c37e6da4",
"canvaskit/chromium/canvaskit.wasm": "ea5ab288728f7200f398f60089048b48",
"canvaskit/canvaskit.js": "26eef3024dbc64886b7f48e1b6fb05cf",
"canvaskit/canvaskit.wasm": "e7602c687313cfac5f495c5eac2fb324",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
