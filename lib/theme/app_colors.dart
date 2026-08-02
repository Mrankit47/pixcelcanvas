import 'package:flutter/material.dart';

/// Centralized color system for PixelCanvas Version 1.0 Design System.
///
/// **Brand Identity**: Apple x Figma x Linear x Arc Browser x Aseprite.
abstract final class AppColors {
  // ── Brand Primary Palette: Deep Cosmic Purple ──
  static const Color primary50 = Color(0xFFF5F3FF);
  static const Color primary100 = Color(0xFFEDE9FE);
  static const Color primary200 = Color(0xFFDDD6FE);
  static const Color primary300 = Color(0xFFC4B5FD);
  static const Color primary400 = Color(0xFFA78BFA);
  static const Color primary500 = Color(0xFF7C3AED); // Electric Violet
  static const Color primary600 = Color(0xFF6D28D9);
  static const Color primary700 = Color(0xFF5B21B6); // Deep Cosmic Purple
  static const Color primary800 = Color(0xFF4C1D95);
  static const Color primary900 = Color(0xFF3B0764);

  // ── Brand Secondary & Accents ──
  static const Color secondary = Color(0xFF7C3AED); // Electric Violet
  static const Color accentCyan = Color(0xFF06B6D4); // Neon Pixel Cyan
  static const Color accentEmerald = Color(0xFF10B981); // Pixel Emerald
  static const Color accentOrange = Color(0xFFF97316); // Pixel Orange

  // ── Neutrals & Surface Colors ──
  static const Color canvas = Color(0xFFFFFFFF); // Pure White
  static const Color background = Color(0xFFF8FAFC); // Soft Pearl White
  static const Color surface = Color(0xFFF5F3FF); // Very Light Lavender
  static const Color panel = Color(0xFFFFFFFF); // Warm White
  static const Color border = Color(0xFFE2E8F0); // Soft Pixel Gray
  static const Color textPrimary = Color(0xFF0F172A); // Near Black
  static const Color textSecondary = Color(0xFF64748B); // Slate Gray

  // ── Neutral Scale Aliases ──
  static const Color neutral0 = Color(0xFFFFFFFF);
  static const Color neutral50 = Color(0xFFF8FAFC);
  static const Color neutral100 = Color(0xFFF1F5F9);
  static const Color neutral200 = Color(0xFFE2E8F0);
  static const Color neutral300 = Color(0xFFCBD5E1);
  static const Color neutral400 = Color(0xFF94A3B8);
  static const Color neutral500 = Color(0xFF64748B);
  static const Color neutral600 = Color(0xFF475569);
  static const Color neutral700 = Color(0xFF334155);
  static const Color neutral800 = Color(0xFF1E293B);
  static const Color neutral900 = Color(0xFF0F172A);

  // ── Semantic Feedback Colors ──
  static const Color successMain = Color(0xFF10B981); // Mint Green
  static const Color warningMain = Color(0xFFF59E0B); // Golden Amber
  static const Color dangerMain = Color(0xFFEF4444); // Coral Red
  static const Color dangerLight = Color(0xFFFEE2E2);
  static const Color dangerDark = Color(0xFFB91C1C);
  static const Color infoMain = Color(0xFF06B6D4); // Neon Cyan

  // ── UI Aliases ──
  static const Color outline = Color(0xFFE2E8F0);
  static const Color outlineFocused = Color(0xFF7C3AED);

  // ── Canvas Engine Rendering Tokens ──
  static const Color canvasBackground = Color(0xFFFFFFFF);
  static const Color gridLine = Color(0x33CBD5E1);
  static const Color gridLineMajor = Color(0x6694A3B8);
  static const Color transparentCheckerLight = Color(0xFFF8FAFC);
  static const Color transparentCheckerDark = Color(0xFFE2E8F0);
  static const Color selectionBorder = Color(0xFF06B6D4);
  static const Color toolPreview = Color(0x337C3AED);
}
