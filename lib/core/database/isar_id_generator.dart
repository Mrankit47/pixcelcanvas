/// Utility helper generating deterministic 64-bit integer Isar IDs from String UUIDs.
int fastHash(String string) {
  var hash = 0x811c9dc5;
  for (var i = 0; i < string.length; i++) {
    hash ^= string.codeUnitAt(i);
    hash = (hash * 0x01000193) & 0x7FFFFFFF;
  }
  return hash;
}
