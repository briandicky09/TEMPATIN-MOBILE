import 'package:material_ui/material_ui.dart';

/// Centralized color tokens preserving TEMPATIN's Warm Paper Notebook aesthetic.
abstract final class AppColors {
  // Brand & Primary CTA
  static const Color primary = Color(0xFF0075DE);
  static const Color primaryPressed = Color(0xFF0066C4);
  static const Color primaryDark = Color(0xFF0054A3);
  static const Color primaryTint = Color(0xFFE6F3FE); // Sky Tint

  // Canvas & Surfaces
  static const Color canvas = Color(0xFFF6F5F4); // Paper Warmth
  static const Color surface = Color(0xFFFFFFFF); // Pure White
  static const Color surfaceDark = Color(0xFF191919);

  // Ink Hierarchy
  static const Color inkPrimary = Color(0xFF000000);
  static const Color inkCharcoal = Color(0xFF111111);
  static const Color inkBody = Color(0xFF615D59); // Graphite
  static const Color inkSecondary = Color(0xFF757575); // Stone
  static const Color inkSlate = Color(0xFF696969);
  static const Color inkMuted = Color(0x66000000); // 40% black

  // Hairline Borders
  static const Color borderHairline = Color(0x14000000); // rgba(0, 0, 0, 0.08)
  static const Color borderStrong = Color(0x29000000); // rgba(0, 0, 0, 0.16)

  // Semantic Status Tokens
  static const Color successBg = Color(0xFFEDF7EE);
  static const Color successText = Color(0xFF166534);

  static const Color warningBg = Color(0xFFFEF9C3);
  static const Color warningText = Color(0xFF854D0E);

  static const Color dangerBg = Color(0xFFFEE2E2);
  static const Color dangerText = Color(0xFF991B1B);

  static const Color infoBg = Color(0xFFE6F3FE);
  static const Color infoText = Color(0xFF0054A3);

  static const Color neutralBg = Color(0xFFF1F1EF);
  static const Color neutralText = Color(0xFF37352F);

  // Sparse Punctuation Accents
  static const Color accentMarigold = Color(0xFFFFB110);
  static const Color accentCoral = Color(0xFFF64932);

  // Skeleton Shimmer
  static const Color skeletonBase = Color(0xFFECEAE7);
  static const Color skeletonHighlight = Color(0xFFF6F5F4);
}
