import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        primaryContainer: AppColors.primaryContainer,
        onPrimaryContainer: AppColors.onPrimaryContainer,
        secondary: AppColors.secondary,
        onSecondary: AppColors.onSecondary,
        secondaryContainer: AppColors.secondaryContainer,
        onSecondaryContainer: AppColors.onSecondaryContainer,
        tertiary: AppColors.tertiary,
        onTertiary: AppColors.onTertiary,
        error: AppColors.error,
        onError: AppColors.onError,
        surface: AppColors.surface,
        onSurface: AppColors.onSurface,
        surfaceContainerHighest: AppColors.surfaceContainer,
        onSurfaceVariant: AppColors.onSurfaceVariant,
        outline: AppColors.outline,
        outlineVariant: AppColors.outlineVariant,
      ),
      textTheme: TextTheme(
        headlineLarge: AppTextStyles.headlineLg,
        headlineMedium: AppTextStyles.headlineMd,
        bodyLarge: AppTextStyles.bodyLg,
        bodyMedium: AppTextStyles.bodyMd,
        bodySmall: AppTextStyles.bodySm,
        labelLarge: AppTextStyles.labelMd,
        labelSmall: AppTextStyles.labelSm,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }

  static ThemeData get darkTheme {
    const darkSurface = Color(0xFF111827);
    const darkSurfaceContainer = Color(0xFF1F2937);
    const darkOnSurface = Color(0xFFF9FAFB);
    const darkOnSurfaceVariant = Color(0xFFD1D5DB);

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: darkSurface,
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.primaryLight,
        onPrimary: AppColors.onBackground,
        primaryContainer: AppColors.primary,
        onPrimaryContainer: AppColors.onPrimary,
        secondary: AppColors.secondaryContainer,
        onSecondary: AppColors.onBackground,
        secondaryContainer: AppColors.secondary,
        onSecondaryContainer: AppColors.onSecondary,
        tertiary: AppColors.tertiaryFixed,
        onTertiary: AppColors.onBackground,
        error: AppColors.errorContainer,
        onError: AppColors.onErrorContainer,
        surface: darkSurface,
        onSurface: darkOnSurface,
        surfaceContainerHighest: darkSurfaceContainer,
        onSurfaceVariant: darkOnSurfaceVariant,
        outline: AppColors.outlineVariant,
        outlineVariant: AppColors.outline,
      ),
      textTheme: TextTheme(
        headlineLarge: AppTextStyles.headlineLg.copyWith(color: darkOnSurface),
        headlineMedium: AppTextStyles.headlineMd.copyWith(color: darkOnSurface),
        bodyLarge: AppTextStyles.bodyLg.copyWith(color: darkOnSurface),
        bodyMedium: AppTextStyles.bodyMd.copyWith(color: darkOnSurface),
        bodySmall: AppTextStyles.bodySm.copyWith(color: darkOnSurfaceVariant),
        labelLarge: AppTextStyles.labelMd.copyWith(color: darkOnSurface),
        labelSmall: AppTextStyles.labelSm.copyWith(color: darkOnSurfaceVariant),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkSurface,
        foregroundColor: AppColors.primaryLight,
        elevation: 0,
        centerTitle: true,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          return states.contains(WidgetState.selected)
              ? AppColors.primaryLight
              : darkOnSurfaceVariant;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          return states.contains(WidgetState.selected)
              ? AppColors.primary.withValues(alpha: 0.55)
              : darkSurfaceContainer;
        }),
      ),
    );
  }
}
