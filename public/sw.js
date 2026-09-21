const addResourcesToCache = async (resources) => {
  const cache = await caches.open("v1");
  await cache.addAll(resources);
};

self.addEventListener("install", (event) => {
  event.waitUntil(
    addResourcesToCache([
      "/",
      "/index.html",
      "/openttd.data",
      "/openttd.js",
      "/openttd.wasm",
      "/manifest.json",
      "/logo512.png",
      "/favicon.ico",
    ]),
  );
  self.skipWaiting();
});

self.addEventListener("fetch", (event) => {
  if (!event.request.url.startsWith('https')) return;
  event.respondWith(
    fetch(event.request)
      .then((networkResponse) => {
        if (networkResponse.status === 200) {
          const responseClone = networkResponse.clone();
          caches.open("v1").then((cache) => {
            cache.put(event.request, responseClone);
          });
        }
        return networkResponse;
      })
      .catch(async () => {
        const cachedResponse = await caches.match(event.request);
        if (cachedResponse) {
          return cachedResponse;
        }
        if (event.request.mode === "navigate") {
          return new Response(
            "<h1>You might delete the web files, connect to internet to reload again.</h1>",
            { headers: { "Content-Type": "text/html; charset=utf-8" } }
          );
        }
      })
  );
});
