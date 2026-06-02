import { router } from 'expo-router';
import { useState } from 'react';
import { Pressable, StyleSheet, Text, TextInput, View } from 'react-native';
import Animated, { FadeInUp } from 'react-native-reanimated';

import { AppButton, AppImage, NavHeader, Pill, ScreenShell, appStyles } from '@/components/AppPrimitives';
import { SAMPLE_DRIVER, STEAMER_HERO, XPRESS_LOGO } from '@/constants/Data';
import { BorderRadius, Colors, Spacing, Typography } from '@/constants/Theme';
import { useCart } from '@/context/CartContext';
import { SPRING_CONFIGS, ScalePressable } from '@/components/AnimatedPrimitives';

const tipOptions = ['Rp 2.000', 'Rp 5.000', 'Custom'];

export default function RateScreen() {
  const { currentOrder } = useCart();
  const [merchantRating, setMerchantRating] = useState(5);
  const [driverRating, setDriverRating] = useState(5);
  const [tip, setTip] = useState('Rp 5.000');

  return (
    <ScreenShell>
      <Animated.View entering={FadeInUp.duration(400)}>
        <View style={styles.navWrap}>
          <NavHeader title="Order Details" onBack={() => router.replace('/(tabs)/orders')} />
        </View>
      </Animated.View>

      <Animated.View entering={FadeInUp.duration(500).delay(100).springify().damping(SPRING_CONFIGS.gentle.damping)}>
        <View style={styles.heroCard}>
          <AppImage uri={STEAMER_HERO} style={styles.heroImage} />
          <AppImage uri={XPRESS_LOGO} style={styles.logo} />
          <Text style={appStyles.screenTitle}>Enjoy your dimsum!</Text>
          <Text style={styles.subtitle}>Your order from Dimsum Nuraos has arrived fresh and hot.</Text>
          {currentOrder ? <Pill label={currentOrder.id} tone="primary" /> : null}
        </View>
      </Animated.View>

      <Animated.View entering={FadeInUp.duration(500).delay(200).springify().damping(SPRING_CONFIGS.gentle.damping)}>
        <View style={styles.ratingCard}>
          <RatingRow label="Dimsum Nuraos" rating={merchantRating} onChangeRating={setMerchantRating} />
          <View style={appStyles.divider} />
          <RatingRow
            label={`${SAMPLE_DRIVER.name}, Dimsum Nuraos Driver`}
            rating={driverRating}
            onChangeRating={setDriverRating}
          />
          <TextInput
            multiline
            placeholder="Write a few words about your experience..."
            placeholderTextColor={Colors.onSurfaceVariant}
            style={styles.feedbackInput}
          />
        </View>
      </Animated.View>

      <Animated.View entering={FadeInUp.duration(500).delay(300).springify().damping(SPRING_CONFIGS.gentle.damping)}>
        <View style={styles.ratingCard}>
          <Text style={appStyles.cardTitle}>Driver Tip</Text>
          <View style={styles.tipGrid}>
            {tipOptions.map((option) => (
              <ScalePressable
                key={option}
                onPress={() => setTip(option)}
                style={[styles.tipButton, tip === option && styles.tipButtonActive]}>
                <Text style={[styles.tipText, tip === option && styles.tipTextActive]}>{option}</Text>
              </ScalePressable>
            ))}
          </View>
        </View>
      </Animated.View>

      <Animated.View entering={FadeInUp.duration(500).delay(400).springify().damping(SPRING_CONFIGS.gentle.damping)}>
        <AppButton label="Back to Home" onPress={() => router.replace('/(tabs)')} />
      </Animated.View>
    </ScreenShell>
  );
}

function RatingRow({
  label,
  rating,
  onChangeRating,
}: {
  label: string;
  rating: number;
  onChangeRating: (rating: number) => void;
}) {
  return (
    <View>
      <Text style={styles.ratingLabel}>{label}</Text>
      <View style={styles.starRow}>
        {[1, 2, 3, 4, 5].map((star) => (
          <ScalePressable key={star} onPress={() => onChangeRating(star)} style={styles.starButton}>
            <Text style={[styles.star, star <= rating && styles.starActive]}>{star <= rating ? '★' : '☆'}</Text>
          </ScalePressable>
        ))}
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  navWrap: {
    marginHorizontal: -Spacing.marginMobile,
    marginTop: -Spacing.marginMobile,
  },
  heroCard: {
    alignItems: 'center',
    marginTop: Spacing.sm,
  },
  heroImage: {
    borderRadius: 28,
    height: 220,
    width: '100%',
  },
  logo: {
    borderRadius: 0,
    height: 26,
    marginTop: 18,
    width: 128,
  },
  subtitle: {
    ...Typography.bodyMd,
    color: Colors.onSurfaceVariant,
    marginBottom: 14,
    marginTop: Spacing.xs,
    textAlign: 'center',
  },
  ratingCard: {
    ...appStyles.card,
    gap: 14,
    marginTop: Spacing.md,
    padding: Spacing.md,
  },
  ratingLabel: {
    ...Typography.labelLg,
    color: Colors.onSurface,
    fontFamily: 'PlusJakartaSans_700Bold',
  },
  starRow: {
    flexDirection: 'row',
    gap: Spacing.xs,
    marginTop: 10,
  },
  starButton: {
    alignItems: 'center',
    backgroundColor: Colors.surfaceContainerLow,
    borderRadius: BorderRadius.full,
    height: 42,
    justifyContent: 'center',
    width: 42,
  },
  star: {
    color: Colors.outline,
    fontSize: 22,
  },
  starActive: {
    color: Colors.starYellow,
  },
  feedbackInput: {
    backgroundColor: Colors.surfaceContainerLow,
    borderColor: Colors.outlineVariant,
    borderRadius: BorderRadius.lg,
    borderWidth: 1,
    color: Colors.onSurface,
    fontFamily: 'BeVietnamPro_400Regular',
    minHeight: 108,
    padding: 14,
    textAlignVertical: 'top',
  },
  tipGrid: {
    flexDirection: 'row',
    gap: 10,
  },
  tipButton: {
    alignItems: 'center',
    backgroundColor: Colors.surfaceContainerLow,
    borderColor: Colors.outlineVariant,
    borderRadius: BorderRadius.lg,
    borderWidth: 1,
    flex: 1,
    paddingVertical: 14,
  },
  tipButtonActive: {
    backgroundColor: Colors.brandTerracotta,
    borderColor: Colors.brandTerracotta,
  },
  tipText: {
    color: Colors.onSurface,
    fontFamily: 'PlusJakartaSans_700Bold',
  },
  tipTextActive: {
    color: Colors.white,
  },
});
