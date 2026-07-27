import 'dart:convert';
import 'package:pixelcanvas/core/release/performance/performance_profiler.dart';

/// Diagnostics system reporter.
class DiagnosticsReporter {
  /// Generates full diagnostic report as JSON string.
  static String generateReport() {
    final perf = PerformanceProfiler.profile();

    final reportMap = {
      'application': 'PixelCanvas',
      'version': '1.0.0-RC1',
      'timestamp': DateTime.now().toIso8601String(),
      'system': {
        'os': 'Windows 11 (x64)',
        'targetPlatform': 'Desktop',
      },
      'performance': {
        'startupTimeMs': perf.startupTimeMs,
        'frameLatencyMs': perf.frameLatencyMs,
        'memoryUsageMb': perf.memoryUsageMb,
        'thumbnailCacheCount': perf.thumbnailCacheCount,
      },
      'status': 'HEALTHY',
    };

    return const JsonEncoder.withIndent('  ').convert(reportMap);
  }
}
