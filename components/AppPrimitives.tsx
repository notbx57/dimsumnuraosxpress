import { ReactNode } from 'react';
import { Image, Pressable, ScrollView, StyleSheet, Text, View, ViewStyle } from 'react-native';
import Animated, { FadeInUp } from 'react-native-reanimated';
import { SafeAreaView } from 'react-native-safe-area-context';

import { BorderRadius, Colors, Layout, Shadows, Spacing, Typography } from '@/constants/Theme';
import { ScalePressable } from './AnimatedPrimitives';

interface SectionHeaderProps {
  title: string;
  action?: string;
  onPressAction?: () => void;
}

export function SectionHeader({ title, action, onPressAction }: SectionHeaderProps) {
  return (
    <View style={styles.sectionHeader}>
      <Text style={styles.sectionTitle}>{title}</Text>
      {action ? (
        <Pressable onPress={onPressAction}>
          <Text style={styles.sectionAction}>{action}</Text>
        </Pressable>
      ) : null}
    </View>
  );
}

export function AnimatedSectionHeader({ title, action, onPressAction, delay = 0 }: SectionHeaderProps & { delay?: number }) {
  return (
    <Animated.View
      entering={FadeInUp.duration(400).delay(delay)}
      style={styles.sectionHeader}
    >
      <Text style={styles.sectionTitle}>{title}</Text>
      {action ? (
        <Pressable onPress={onPressAction}>
          <Text style={styles.sectionAction}>{action}</Text>
        </Pressable>
      ) : null}
    </Animated.View>
  );
}

interface PillProps {
  label: string;
  tone?: 'primary' | 'light' | 'outline';
}

export function Pill({ label, tone = 'light' }: PillProps) {
  return (
    <View
      style={[
        styles.pill,
        tone === 'primary' && styles.pillPrimary,
        tone === 'outline' && styles.pillOutline,
      ]}>
      <Text style={[styles.pillText, tone === 'primary' && styles.pillTextPrimary]}>{label}</Text>
    </View>
  );
}

interface IconButtonProps {
  label?: string;
  icon?: ReactNode;
  onPress?: () => void;
  variant?: 'primary' | 'secondary' | 'ghost';
  size?: 'sm' | 'md';
  accessibilityLabel?: string;
}

export function IconButton({
  label,
  icon,
  onPress,
  variant = 'secondary',
  size = 'md',
  accessibilityLabel,
}: IconButtonProps) {
  const content = icon ?? (label ? <Text style={[styles.iconButtonText, variant === 'primary' && styles.iconButtonTextPrimary]}>{label}</Text> : null);

  return (
    <ScalePressable
      accessibilityLabel={accessibilityLabel ?? label}
      accessibilityRole="button"
      onPress={onPress}
      style={({ pressed }: { pressed: boolean }) => [
        styles.iconButton,
        size === 'sm' && styles.iconButtonSm,
        variant === 'primary' && styles.iconButtonPrimary,
        variant === 'ghost' && styles.iconButtonGhost,
      ]}>
      {content}
    </ScalePressable>
  );
}

interface AppButtonProps {
  label: string;
  onPress?: () => void;
  disabled?: boolean;
  variant?: 'primary' | 'outline';
}

export function AppButton({ label, onPress, disabled, variant = 'primary' }: AppButtonProps) {
  return (
    <ScalePressable
      accessibilityRole="button"
      disabled={disabled}
      onPress={onPress}
      style={({ pressed }: { pressed: boolean }) => [
        styles.button,
        variant === 'outline' && styles.buttonOutline,
        disabled && styles.buttonDisabled,
      ]}>
      <Text style={[styles.buttonText, variant === 'outline' && styles.buttonOutlineText]}>
        {label}
      </Text>
    </ScalePressable>
  );
}

interface AppImageProps {
  uri: string;
  style?: object;
}

export function AppImage({ uri, style }: AppImageProps) {
  return <Image source={{ uri }} style={[styles.image, style]} resizeMode="cover" />;
}

interface ScreenHeaderProps {
  eyebrow?: string;
  title: string;
}

export function ScreenHeader({ eyebrow, title }: ScreenHeaderProps) {
  return (
    <View style={styles.screenHeader}>
      {eyebrow ? <Text style={appStyles.eyebrow}>{eyebrow}</Text> : null}
      <Text style={appStyles.screenTitle}>{title}</Text>
    </View>
  );
}

interface NavHeaderProps {
  title: string;
  onBack: () => void;
  rightSlot?: ReactNode;
}

export function NavHeader({ title, onBack, rightSlot }: NavHeaderProps) {
  return (
    <View style={styles.navHeader}>
      <Pressable accessibilityRole="button" onPress={onBack} style={styles.backButton}>
        <Text style={styles.backText}>←</Text>
      </Pressable>
      <Text style={styles.navTitle}>{title}</Text>
      {rightSlot ?? <View style={styles.navSpacer} />}
    </View>
  );
}

interface SummaryLineProps {
  label: string;
  value: string;
  strong?: boolean;
}

export function SummaryLine({ label, value, strong }: SummaryLineProps) {
  return (
    <View style={appStyles.summaryLine}>
      <Text style={[appStyles.summaryLabel, strong && appStyles.summaryStrong]}>{label}</Text>
      <Text style={[appStyles.summaryValue, strong && appStyles.summaryStrong]}>{value}</Text>
    </View>
  );
}

interface ScreenShellProps {
  children: ReactNode;
  scrollable?: boolean;
  edges?: ('top' | 'bottom' | 'left' | 'right')[];
  contentStyle?: ViewStyle;
}

export function ScreenShell({
  children,
  scrollable = true,
  edges = ['top'],
  contentStyle,
}: ScreenShellProps) {
  if (!scrollable) {
    return (
      <SafeAreaView edges={edges} style={appStyles.screen}>
        {children}
      </SafeAreaView>
    );
  }

  return (
    <SafeAreaView edges={edges} style={appStyles.screen}>
      <ScrollView
        contentContainerStyle={[appStyles.content, contentStyle]}
        showsVerticalScrollIndicator={false}>
        {children}
      </ScrollView>
    </SafeAreaView>
  );
}

export const appStyles = StyleSheet.create({
  screen: {
    flex: 1,
    backgroundColor: Colors.background,
  },
  content: {
    paddingHorizontal: Spacing.marginMobile,
    paddingTop: Spacing.marginMobile,
    paddingBottom: Layout.tabBarHeight + 44,
  },
  card: {
    backgroundColor: Colors.surfaceContainerLowest,
    borderColor: Colors.outlineVariant,
    borderRadius: BorderRadius.lg,
    borderWidth: 1,
    ...Shadows.md,
  },
  row: {
    alignItems: 'center',
    flexDirection: 'row',
  },
  eyebrow: {
    ...Typography.labelSm,
    color: Colors.brandTerracotta,
    letterSpacing: 0.8,
    textTransform: 'uppercase',
  },
  screenTitle: {
    ...Typography.headlineLg,
    color: Colors.onSurface,
    marginTop: Spacing.xs,
  },
  muted: {
    ...Typography.bodySm,
    color: Colors.onSurfaceVariant,
    lineHeight: 21,
  },
  cardTitle: {
    ...Typography.headlineSm,
    color: Colors.onSurface,
  },
  sectionEyebrow: {
    ...Typography.labelSm,
    color: Colors.brandTerracotta,
    letterSpacing: 0.6,
    marginBottom: Spacing.xs,
    textTransform: 'uppercase',
  },
  divider: {
    backgroundColor: Colors.outlineVariant,
    height: 1,
  },
  summaryLine: {
    alignItems: 'center',
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
  summaryLabel: {
    ...Typography.bodySm,
    color: Colors.onSurfaceVariant,
    fontFamily: 'PlusJakartaSans_500Medium',
  },
  summaryValue: {
    ...Typography.bodySm,
    color: Colors.onSurface,
    fontFamily: 'PlusJakartaSans_600SemiBold',
  },
  summaryStrong: {
    ...Typography.labelLg,
    color: Colors.onSurface,
    fontFamily: 'PlusJakartaSans_700Bold',
  },
});

const styles = StyleSheet.create({
  sectionHeader: {
    alignItems: 'center',
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: 12,
    marginTop: 24,
  },
  sectionTitle: {
    ...Typography.headlineSm,
    color: Colors.onSurface,
  },
  sectionAction: {
    ...Typography.labelSm,
    color: Colors.brandTerracotta,
    fontFamily: 'PlusJakartaSans_600SemiBold',
  },
  pill: {
    alignSelf: 'flex-start',
    backgroundColor: Colors.secondaryContainer,
    borderRadius: 999,
    paddingHorizontal: 10,
    paddingVertical: 6,
  },
  pillPrimary: {
    backgroundColor: Colors.brandTerracotta,
  },
  pillOutline: {
    backgroundColor: Colors.white,
    borderColor: Colors.outlineVariant,
    borderWidth: 1,
  },
  pillText: {
    color: Colors.onSurfaceVariant,
    fontSize: 11,
    fontFamily: 'PlusJakartaSans_600SemiBold',
  },
  pillTextPrimary: {
    color: Colors.white,
  },
  iconButton: {
    alignItems: 'center',
    backgroundColor: Colors.secondaryContainer,
    borderRadius: 999,
    height: 40,
    justifyContent: 'center',
    minWidth: 40,
    paddingHorizontal: 12,
  },
  iconButtonSm: {
    height: 32,
    minWidth: 32,
    paddingHorizontal: 8,
  },
  iconButtonPrimary: {
    backgroundColor: Colors.brandTerracotta,
  },
  iconButtonGhost: {
    backgroundColor: Colors.surfaceContainerLow,
  },
  iconButtonText: {
    color: Colors.brandTerracotta,
    fontSize: 18,
    fontFamily: 'PlusJakartaSans_700Bold',
  },
  iconButtonTextPrimary: {
    color: Colors.white,
  },
  button: {
    alignItems: 'center',
    backgroundColor: Colors.brandTerracotta,
    borderRadius: 999,
    minHeight: 52,
    justifyContent: 'center',
    paddingHorizontal: 20,
    ...Shadows.md,
  },
  buttonOutline: {
    backgroundColor: Colors.white,
    borderColor: Colors.outlineVariant,
    borderWidth: 1,
    shadowOpacity: 0,
  },
  buttonDisabled: {
    backgroundColor: Colors.outlineVariant,
  },
  buttonText: {
    color: Colors.white,
    fontSize: 16,
    fontFamily: 'PlusJakartaSans_700Bold',
  },
  buttonOutlineText: {
    color: Colors.brandTerracotta,
  },
  image: {
    backgroundColor: Colors.surfaceContainer,
  },
  pressed: {
    opacity: 0.72,
    transform: [{ scale: 0.98 }],
  },
  screenHeader: {
    marginBottom: Spacing.xs,
  },
  navHeader: {
    alignItems: 'center',
    flexDirection: 'row',
    justifyContent: 'space-between',
    paddingHorizontal: Spacing.marginMobile,
    paddingVertical: Spacing.md,
  },
  backButton: {
    alignItems: 'center',
    backgroundColor: Colors.surfaceContainerLow,
    borderRadius: BorderRadius.full,
    height: 40,
    justifyContent: 'center',
    width: 40,
  },
  backText: {
    color: Colors.onSurface,
    fontFamily: 'PlusJakartaSans_700Bold',
    fontSize: 18,
    lineHeight: 20,
  },
  navTitle: {
    ...Typography.labelLg,
    color: Colors.onSurface,
  },
  navSpacer: {
    width: 40,
  },
});
