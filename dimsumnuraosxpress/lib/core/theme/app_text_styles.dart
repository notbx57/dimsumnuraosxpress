import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // Plus Jakarta Sans for Headlines
  static TextStyle headlineXl = GoogleFonts.plusJakartaSans(
    fontSize: 40.0,
    fontWeight: FontWeight.bold,
    height: 48.0 / 40.0,
    letterSpacing: -0.02 * 40.0,
    color: AppColors.onBackground,
  );

  static TextStyle headlineLg = GoogleFonts.plusJakartaSans(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    height: 40.0 / 32.0,
    letterSpacing: -0.01 * 32.0,
    color: AppColors.onBackground,
  );

  static TextStyle headlineMd = GoogleFonts.plusJakartaSans(
    fontSize: 24.0,
    fontWeight: FontWeight.w600,
    height: 32.0 / 24.0,
    color: AppColors.onBackground,
  );

  // Be Vietnam Pro for Body text
  static TextStyle bodyLg = GoogleFonts.beVietnamPro(
    fontSize: 18.0,
    fontWeight: FontWeight.normal,
    height: 28.0 / 18.0,
    color: AppColors.onBackground,
  );

  static TextStyle bodyMd = GoogleFonts.beVietnamPro(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    height: 24.0 / 16.0,
    color: AppColors.onBackground,
  );

  static TextStyle bodySm = GoogleFonts.beVietnamPro(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    height: 20.0 / 14.0,
    color: AppColors.onSurfaceVariant,
  );

  // Plus Jakarta Sans for Labels
  static TextStyle labelMd = GoogleFonts.plusJakartaSans(
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
    height: 16.0 / 14.0,
    color: AppColors.onBackground,
  );

  static TextStyle labelSm = GoogleFonts.plusJakartaSans(
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    height: 14.0 / 12.0,
    color: AppColors.onSurfaceVariant,
  );
}
