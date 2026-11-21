import 'package:material_ui/material_ui.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Mobile-adapted editorial typography scale (Inter primary, Source Serif 4 accent).
abstract final class AppTypography {
  static TextStyle get displaySm => GoogleFonts.inter(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.18,
    letterSpacing: -0.8,
    color: AppColors.inkPrimary,
  );

  static TextStyle get headingLg => GoogleFonts.inter(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    height: 1.25,
    letterSpacing: -0.4,
    color: AppColors.inkPrimary,
  );

  static TextStyle get headingMd => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.30,
    letterSpacing: -0.2,
    color: AppColors.inkPrimary,
  );

  static TextStyle get headingSm => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.35,
    letterSpacing: -0.1,
    color: AppColors.inkPrimary,
  );

  static TextStyle get body => GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.50,
    color: AppColors.inkBody,
  );

  static TextStyle get bodySm => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.43,
    color: AppColors.inkBody,
  );

  static TextStyle get label => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.20,
    color: AppColors.inkCharcoal,
  );

  static TextStyle get caption => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.33,
    letterSpacing: 0.1,
    color: AppColors.inkSecondary,
  );

  /// Editorial serif accent reserved sparingly for hero subheads and quotes.
  static TextStyle get editorialSubhead => GoogleFonts.sourceSerif4(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.50,
    color: AppColors.inkBody,
  );

  static TextTheme get textTheme => TextTheme(
    displaySmall: displaySm,
    headlineLarge: headingLg,
    headlineMedium: headingMd,
    headlineSmall: headingSm,
    titleMedium: headingSm,
    titleSmall: label,
    bodyLarge: body,
    bodyMedium: bodySm,
    labelLarge: label,
    bodySmall: caption,
    labelSmall: caption,
  );
}
