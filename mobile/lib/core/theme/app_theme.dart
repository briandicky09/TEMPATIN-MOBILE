import 'package:material_ui/material_ui.dart';

/// TEMPATIN visual identity tokens: Crisp Black, Pure White, Warm Canvas, and TEMPATIN Blue.
abstract final class AppColors {
  static const Color primary = Color(0xFF0075DE);
  static const Color primaryDark = Color(0xFF0054A3);
  static const Color primaryTint = Color(0xFFE6F3FE);

  static const Color canvas = Color(0xFFF6F5F4);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color inkPrimary = Color(0xFF000000);
  static const Color inkCharcoal = Color(0xFF111111);
  static const Color inkBody = Color(0xFF595652);
  static const Color inkMuted = Color(0xFF76736E);

  static const Color borderHairline = Color(0x14000000);
  static const Color borderStrong = Color(0x29000000);

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

  static const Color ratingStar = Color(0xFFFFB110);
}

abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
}

abstract final class AppRadii {
  static final BorderRadius card = BorderRadius.circular(12);
  static final BorderRadius button = BorderRadius.circular(8);
  static final BorderRadius pill = BorderRadius.circular(9999);
}

abstract final class AppTypography {
  static const TextStyle displaySm = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.6,
    color: AppColors.inkPrimary,
  );

  static const TextStyle headingLg = TextStyle(
    fontSize: 21,
    fontWeight: FontWeight.w700,
    height: 1.25,
    letterSpacing: -0.4,
    color: AppColors.inkPrimary,
  );

  static const TextStyle headingMd = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: -0.2,
    color: AppColors.inkPrimary,
  );

  static const TextStyle headingSm = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    height: 1.35,
    color: AppColors.inkCharcoal,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: AppColors.inkBody,
  );

  static const TextStyle bodySm = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.45,
    color: AppColors.inkBody,
  );

  static const TextStyle label = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    height: 1.2,
    color: AppColors.inkCharcoal,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.35,
    color: AppColors.inkMuted,
  );
}

abstract final class AppTheme {
  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      surface: AppColors.surface,
      error: AppColors.dangerText,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.canvas,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.inkPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: AppTypography.headingMd,
        shape: Border(
          bottom: BorderSide(color: AppColors.borderHairline, width: 1),
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadii.card,
          side: const BorderSide(color: AppColors.borderHairline, width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: AppRadii.button,
          borderSide: const BorderSide(color: AppColors.borderStrong),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadii.button,
          borderSide: const BorderSide(color: AppColors.borderHairline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadii.button,
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadii.button,
          borderSide: const BorderSide(color: AppColors.dangerText),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.inkMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(fontSize: 11),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surface,
        selectedColor: AppColors.primaryTint,
        labelStyle: AppTypography.label,
        side: const BorderSide(color: AppColors.borderHairline),
        shape: RoundedRectangleBorder(borderRadius: AppRadii.pill),
      ),
    );
  }
}
