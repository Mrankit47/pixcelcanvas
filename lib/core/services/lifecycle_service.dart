import 'package:flutter/widgets.dart';
import 'package:pixelcanvas/core/utils/logger.dart';

/// Observer service monitoring Flutter application lifecycle transitions.
///
/// Logs foreground (`resumed`), background (`paused`), `inactive`, and `detached` states
/// per Blueprint §11.3 (auto-save on pause/inactive) without feature logic.
class LifecycleService with WidgetsBindingObserver {
  /// Initializes the observer listener with [WidgetsBinding].
  void initialize() {
    WidgetsBinding.instance.addObserver(this);
    Logger.i('LifecycleService observer registered');
  }

  /// Removes the observer listener.
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    Logger.i('LifecycleService observer unregistered');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        Logger.i('App Lifecycle Transition: FOREGROUND (resumed)');
      case AppLifecycleState.inactive:
        Logger.i('App Lifecycle Transition: INACTIVE');
      case AppLifecycleState.paused:
        Logger.i('App Lifecycle Transition: BACKGROUND (paused)');
      case AppLifecycleState.detached:
        Logger.i('App Lifecycle Transition: DETACHED');
      case AppLifecycleState.hidden:
        Logger.i('App Lifecycle Transition: HIDDEN');
    }
  }
}
