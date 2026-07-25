/// Utility helper generating deterministic 64-bit integer Isar IDs from String UUIDs.
int fastHash(String string) {
  var hash = 0xcbf29ce484222325;
  for (var i = 0; i < string.length; i++) {
    hash ^= string.codeUnitAt(i);
    hash *= 0x100000001b3;
    hash &= 0x7FFFFFFFFFFFFFFF;
  }
  return hash;
}
