# Core Cache

In-memory and local disk caching infrastructure per Blueprint §8.1 and §11.1.

## Components

- **`cache_policy.dart`**: Caching strategy enumeration (`cacheFirst`, `networkFirst`, `cacheOnly`, `networkOnly`).
- **`cache_metadata.dart`**: TTL tracking, expiration timestamps, and cache key descriptors.
- **`cache_result.dart`**: Cache operation status container (`hit`, `miss`, `expired`).
- **`cache_manager.dart`**: Generic in-memory LRU cache manager with TTL eviction.
