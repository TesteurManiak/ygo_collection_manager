'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "index.html": "d0cf10d195e1ec88066286b4af73a781",
"/": "d0cf10d195e1ec88066286b4af73a781",
"manifest.json": "9d63b52877ee49e1d09e2b78fa7b58ec",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"version.json": "7ad1333db0f7c593025756cd416b88b0",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"assets/FontManifest.json": "a34c34da3a29a2bd21ac28975e64a531",
"assets/NOTICES": "5395fe6b2b047e4bb579a0da55446f7a",
"assets/fonts/MaterialIcons-Regular.otf": "7e7a6cccddf6d7b20012a548461d5d81",
"assets/packages/alchemist/assets/fonts/Roboto/Roboto-Regular.ttf": "3e1af3ef546b9e6ecef9f3ba197bf7d2",
"assets/packages/alchemist/assets/fonts/Roboto/Roboto-Black.ttf": "ec4c9962ba54eb91787aa93d361c10a8",
"assets/packages/alchemist/assets/fonts/Roboto/Roboto-Thin.ttf": "89e2666c24d37055bcb60e9d2d9f7e35",
"assets/packages/alchemist/assets/fonts/Roboto/Roboto-Bold.ttf": "ee7b96fa85d8fdb8c126409326ac2d2b",
"assets/packages/alchemist/assets/fonts/Roboto/Roboto-Light.ttf": "fc84e998bc29b297ea20321e4c90b6ed",
"assets/packages/alchemist/assets/fonts/Roboto/Roboto-Medium.ttf": "d08840599e05db7345652d3d417574a9",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/assets/back_high.jpg": "9fd8bb791397f452f854cd34e4aacfa1",
"assets/assets/level/level.png": "7a8d6bd8d9b3dfa1ed25995b33946492",
"assets/assets/level/rank.png": "c3b9540714bc1a5a673ef986bc449fea",
"assets/assets/type/XYZ%2520Monster.jpg": "c7fb93791c8d134b7082eddc02860632",
"assets/assets/type/Trap%2520Card.jpg": "906ac4dcd8f8b17ffaa308a6218f76ca",
"assets/assets/type/Effect%2520Monster.jpg": "d5d868e99318c4caffe697c5742f0fb0",
"assets/assets/type/Synchro%2520Pendulum%2520Effect%2520Monster.jpg": "d035db80afafa8bed4ee52cf0609886c",
"assets/assets/type/Normal%2520Monster.jpg": "963afc0c1a1bc0426639494c3d740c4b",
"assets/assets/type/Ritual%2520Monster.jpg": "be05b5c9786409d34d01c67c48d5f45f",
"assets/assets/type/Toon%2520Monster.jpg": "d5d868e99318c4caffe697c5742f0fb0",
"assets/assets/type/XYZ%2520Pendulum%2520Effect%2520Monster.jpg": "9081cb6917d2f08943114efc5ab1a160",
"assets/assets/type/Synchro%2520Tuner%2520Monster.jpg": "6390159705bea8063fd83c404d1233d2",
"assets/assets/type/Link%2520Monster.jpg": "3d37406a056463bec7a51d4a0dbfd93e",
"assets/assets/type/Pendulum%2520Effect%2520Monster.jpg": "b0dffbacaf19857edeba49dbc9e9263c",
"assets/assets/type/Synchro%2520Monster.jpg": "6390159705bea8063fd83c404d1233d2",
"assets/assets/type/Fusion%2520Monster.jpg": "b2da7d57fbaedf6cf38f21bebd2aa262",
"assets/assets/type/Pendulum%2520Tuner%2520Effect%2520Monster.jpg": "b0dffbacaf19857edeba49dbc9e9263c",
"assets/assets/type/Pendulum%2520Normal%2520Monster.jpg": "bbcb69796b84bb263f51fd81f1fd5e47",
"assets/assets/type/Tuner%2520Monster.jpg": "d5d868e99318c4caffe697c5742f0fb0",
"assets/assets/type/Token.jpg": "749b8f308936d5a5493657b61f7c60d1",
"assets/assets/type/Union%2520Effect%2520Monster.jpg": "d5d868e99318c4caffe697c5742f0fb0",
"assets/assets/type/Flip%2520Effect%2520Monster.jpg": "d5d868e99318c4caffe697c5742f0fb0",
"assets/assets/type/Gemini%2520Monster.jpg": "d5d868e99318c4caffe697c5742f0fb0",
"assets/assets/type/Pendulum%2520Flip%2520Effect%2520Monster.jpg": "b0dffbacaf19857edeba49dbc9e9263c",
"assets/assets/type/Ritual%2520Effect%2520Monster.jpg": "be05b5c9786409d34d01c67c48d5f45f",
"assets/assets/type/Normal%2520Tuner%2520Monster.jpg": "963afc0c1a1bc0426639494c3d740c4b",
"assets/assets/type/Skill%2520Card.jpg": "e796e7ca00ae864883ad1170dad3c3b6",
"assets/assets/type/Pendulum%2520Effect%2520Fusion%2520Monster.jpg": "cfd48ad5002f760f370adccfcd089e19",
"assets/assets/type/Spirit%2520Monster.jpg": "d5d868e99318c4caffe697c5742f0fb0",
"assets/assets/type/Spell%2520Card.jpg": "51b72df5673ddc0661e6144182ecbdea",
"assets/assets/fonts/Roboto/Roboto-Regular.ttf": "f36638c2135b71e5a623dca52b611173",
"assets/assets/fonts/Roboto/Roboto-Black.ttf": "301fe70f8f0f41c236317504ec05f820",
"assets/assets/fonts/Roboto/Roboto-Thin.ttf": "4f0b85f5b601a405bdc7b23aad6d2a47",
"assets/assets/fonts/Roboto/Roboto-Bold.ttf": "9ece5b48963bbc96309220952cda38aa",
"assets/assets/fonts/Roboto/Roboto-Light.ttf": "6090d256d88dcd7f0244eaa4a3eafbba",
"assets/assets/fonts/Roboto/Roboto-Medium.ttf": "b2d307df606f23cb14e6483039e2b7fa",
"assets/assets/magic_circle.png": "19f5ea55a9ea6d6d456c8113c1ae5c6e",
"assets/assets/race/Machine.png": "c1c666ed77a1e5edb47d19027c446717",
"assets/assets/race/Winged%2520Beast.png": "085569dc844fb237edbc57464174ffda",
"assets/assets/race/Aqua.png": "609328692f6815721d19fb53ce6ff024",
"assets/assets/race/Pyro.png": "90ae512cfdb417ef2f9036fd49cd3081",
"assets/assets/race/Fish.png": "1cac194135e11dd16ba52be3fac44031",
"assets/assets/race/Quick-Play.png": "3477b2cf458fb0966297a7c38b905e86",
"assets/assets/race/Insect.png": "5dfeaba9e9470816d972436857b9e5fc",
"assets/assets/race/Zombie.png": "3d64d2354fe6e55aef9f5f2f0f504bdd",
"assets/assets/race/Creator-God.png": "e82171a75a74fb8dfdaac05dcae77950",
"assets/assets/race/Warrior.png": "12bfe43603156bed4d8b516c724dcff3",
"assets/assets/race/Dragon.png": "505817fd12f00c13934d67b9f7120280",
"assets/assets/race/Cyberse.png": "c1c666ed77a1e5edb47d19027c446717",
"assets/assets/race/Beast-Warrior.png": "ccc74d6e081fdb64d3df49d0ed3c19e9",
"assets/assets/race/Wyrm.png": "9b966147f212269a832009a24d8c7cb7",
"assets/assets/race/Divine-Beast.png": "eb8aad8366e94995a5422e3e7270e86e",
"assets/assets/race/Beast.png": "b17289d8064cc34e96d36af0d09b5a1d",
"assets/assets/race/Counter.png": "efba4e993d569436bdbcb24e4915a658",
"assets/assets/race/Ritual.png": "ff5c1c1981a34767e554425251ef0d16",
"assets/assets/race/Psychic.png": "b85ad67db10ad13a7f52014ee89b8087",
"assets/assets/race/Normal.png": "fe4c852b7a4ccda9910c1445d9daa3ab",
"assets/assets/race/Sea%2520Serpent.png": "a1b7de871e7f09c45f7c3f8a29f9307f",
"assets/assets/race/Plant.png": "62316bae75499e8c5f75b5c83aef4daa",
"assets/assets/race/Field.png": "3626926fe0511275beca7e80338de6c1",
"assets/assets/race/Fiend.png": "73fcc0e3fa0cd9acc1e90ff0ce17fc5e",
"assets/assets/race/Equip.png": "0f9fab5d008099ac1edcc45851e1a527",
"assets/assets/race/Reptile.png": "45b8899a82f83169c179fb1557ade27e",
"assets/assets/race/Thunder.png": "3298df278599465b32fd43492ea22dae",
"assets/assets/race/Continuous.png": "9e81f060b071fe35c85207127b6d28cb",
"assets/assets/race/Fairy.png": "4074a3558934dba22236b0a8b85d8bae",
"assets/assets/race/Spellcaster.png": "10e2d6a36058215bf3d9a5a3664a134f",
"assets/assets/race/Dinosaur.png": "68ea012222754b2782228f0adbb7f877",
"assets/assets/race/Rock.png": "e4a399d2fc2ecb1a0e2ff99b72bb2a1f",
"assets/assets/attribute/WATER.png": "cfe046a2db82a3585e692bd82fef3533",
"assets/assets/attribute/WIND.png": "483704f2a1705b433560798a6091960c",
"assets/assets/attribute/FIRE.png": "69902aa91dda35b2fabb116fc0562eb5",
"assets/assets/attribute/EARTH.png": "b4a7f532745be8267516c7cbafbf4da6",
"assets/assets/attribute/LIGHT.png": "b0c05659607e612a022011e09fac27ff",
"assets/assets/attribute/DIVINE.png": "ae082ab4ac60618ddcc4053a0137e884",
"assets/assets/attribute/DARK.png": "2fbb1d87fff4d1f81d4cf32a87be63f8",
"assets/AssetManifest.json": "904fd1337e4a0f95b1ec7b1f094c3449",
"canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"canvaskit/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba",
"main.dart.js": "cf5456d75d1b14dfe4251fc58098e1b0"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
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
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
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
