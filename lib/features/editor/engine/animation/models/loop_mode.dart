/// Looping mode behaviors for animation clip playback.
enum LoopMode {
  /// Repeats playback infinitely from start frame to end frame.
  loop,

  /// Plays forward to end frame, then reverses direction back to start frame.
  pingPong,

  /// Plays from start frame to end frame once and stops on final frame.
  playOnce,
}
