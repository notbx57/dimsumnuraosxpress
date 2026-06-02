/**
 * Dimsum Nuraos Xpress — Design Token System
 * Based on the Stitch Design System & PRD specifications.
 */

export const Colors = {
  // Brand & Action
  primary: '#9e3d00',
  primaryContainer: '#c64f00',
  onPrimary: '#ffffff',
  onPrimaryContainer: '#fffbff',
  primaryFixed: '#ffdbcd',
  primaryFixedDim: '#ffb595',
  onPrimaryFixed: '#351000',
  onPrimaryFixedVariant: '#7c2e00',
  inversePrimary: '#ffb595',

  // Secondary (Bamboo Wood)
  secondary: '#75584d',
  secondaryContainer: '#fed7ca',
  onSecondary: '#ffffff',
  onSecondaryContainer: '#795c51',
  secondaryFixed: '#ffdbce',
  secondaryFixedDim: '#e4beb2',
  onSecondaryFixed: '#2b160f',
  onSecondaryFixedVariant: '#5b4137',

  // Tertiary (Steam Cream)
  tertiary: '#71582c',
  tertiaryContainer: '#8c7042',
  onTertiary: '#ffffff',
  onTertiaryContainer: '#fffbff',
  tertiaryFixed: '#ffdeaa',
  tertiaryFixedDim: '#e3c28c',
  onTertiaryFixed: '#271900',
  onTertiaryFixedVariant: '#5a4319',

  // Surfaces & Backgrounds
  background: '#f7f9ff',
  surface: '#f7f9ff',
  surfaceBright: '#f7f9ff',
  surfaceDim: '#c9dcf3',
  surfaceContainerLowest: '#ffffff',
  surfaceContainerLow: '#edf4ff',
  surfaceContainer: '#e3efff',
  surfaceContainerHigh: '#d9eaff',
  surfaceContainerHighest: '#d1e4fb',
  surfaceVariant: '#d1e4fb',
  surfaceTint: '#a23f00',

  // Text
  onBackground: '#091d2e',
  onSurface: '#091d2e',
  onSurfaceVariant: '#594238',
  inverseSurface: '#203243',
  inverseOnSurface: '#e8f2ff',

  // Outlines
  outline: '#8c7166',
  outlineVariant: '#e0c0b2',

  // Error
  error: '#ba1a1a',
  onError: '#ffffff',
  errorContainer: '#ffdad6',
  onErrorContainer: '#93000a',

  // Extra brand accents (from Stitch override colors)
  brandTerracotta: '#d35400',
  brandBamboo: '#8d6e63',
  brandSteamCream: '#fad7a0',
  brandNeutral: '#2c3e50',

  // Utility
  white: '#ffffff',
  black: '#000000',
  transparent: 'transparent',
  starYellow: '#f59e0b',
  successGreen: '#22c55e',
};

export const Spacing = {
  base: 4,
  xs: 8,
  sm: 12,
  md: 16,
  gutter: 16,
  lg: 24,
  xl: 32,
  marginMobile: 20,
  marginDesktop: 48,
};

export const BorderRadius = {
  sm: 4,
  default: 8,
  md: 12,
  lg: 16,
  xl: 24,
  full: 9999,
};

export const Shadows = {
  sm: {
    shadowColor: '#d35400',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.06,
    shadowRadius: 8,
    elevation: 2,
  },
  md: {
    shadowColor: '#d35400',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.08,
    shadowRadius: 12,
    elevation: 4,
  },
  lg: {
    shadowColor: '#9e3d00',
    shadowOffset: { width: 0, height: 8 },
    shadowOpacity: 0.12,
    shadowRadius: 24,
    elevation: 8,
  },
  nav: {
    shadowColor: '#9e3d00',
    shadowOffset: { width: 0, height: -4 },
    shadowOpacity: 0.08,
    shadowRadius: 12,
    elevation: 8,
  },
};

/** Portrait phone frame — width:height (e.g. 9:19.5 ≈ iPhone). */
export const Layout = {
  viewportWidth: 9,
  viewportHeight: 19.5,
  maxViewportWidth: 430,
  frameBorderRadius: 28,
  tabBarHeight: 76,
  cartPopupBottomOffset: 92,
};

export const Typography = {
  headlineXl: {
    fontFamily: 'PlusJakartaSans_700Bold',
    fontSize: 40,
    lineHeight: 48,
    letterSpacing: -0.8,
  },
  headlineLg: {
    fontFamily: 'PlusJakartaSans_700Bold',
    fontSize: 32,
    lineHeight: 40,
    letterSpacing: -0.32,
  },
  headlineMd: {
    fontFamily: 'PlusJakartaSans_600SemiBold',
    fontSize: 24,
    lineHeight: 32,
  },
  headlineSm: {
    fontFamily: 'PlusJakartaSans_600SemiBold',
    fontSize: 20,
    lineHeight: 28,
  },
  labelLg: {
    fontFamily: 'PlusJakartaSans_600SemiBold',
    fontSize: 16,
    lineHeight: 20,
  },
  labelMd: {
    fontFamily: 'PlusJakartaSans_600SemiBold',
    fontSize: 14,
    lineHeight: 16,
  },
  labelSm: {
    fontFamily: 'PlusJakartaSans_500Medium',
    fontSize: 12,
    lineHeight: 14,
  },
  bodyLg: {
    fontFamily: 'BeVietnamPro_400Regular',
    fontSize: 18,
    lineHeight: 28,
  },
  bodyMd: {
    fontFamily: 'BeVietnamPro_400Regular',
    fontSize: 16,
    lineHeight: 24,
  },
  bodySm: {
    fontFamily: 'BeVietnamPro_400Regular',
    fontSize: 14,
    lineHeight: 20,
  },
  bodyXs: {
    fontFamily: 'BeVietnamPro_400Regular',
    fontSize: 12,
    lineHeight: 16,
  },
};
