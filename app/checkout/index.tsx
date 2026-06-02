import { router } from 'expo-router';
import { useState } from 'react';
import { ImageBackground, Pressable, ScrollView, StyleSheet, Text, TextInput, View } from 'react-native';
import Animated, { FadeInUp, SlideInDown } from 'react-native-reanimated';
import { SafeAreaView } from 'react-native-safe-area-context';

import {
  AppButton,
  AppImage,
  Pill,
  SummaryLine,
  appStyles,
} from '@/components/AppPrimitives';
import { MINI_MAP_IMAGE, SAMPLE_ADDRESS, SAMPLE_USER, XPRESS_LOGO, formatRupiah } from '@/constants/Data';
import { BorderRadius, Colors, Shadows, Spacing, Typography } from '@/constants/Theme';
import { useCart } from '@/context/CartContext';
import { SPRING_CONFIGS, ScalePressable } from '@/components/AnimatedPrimitives';

type PaymentMethod = 'E-wallet' | 'Credit Card' | 'Cash on Delivery';

const paymentMethods: PaymentMethod[] = ['E-wallet', 'Credit Card', 'Cash on Delivery'];

export default function CheckoutScreen() {
  const { cart, subtotal, deliveryFee, serviceFee, total, placeOrder } = useCart();
  const [address, setAddress] = useState(`${SAMPLE_ADDRESS.street}, ${SAMPLE_ADDRESS.city}`);
  const [paymentMethod, setPaymentMethod] = useState<PaymentMethod>('E-wallet');

  const canPlaceOrder = cart.length > 0 && address.trim().length > 0;

  function handlePlaceOrder() {
    if (!canPlaceOrder) {
      return;
    }

    const order = placeOrder(paymentMethod, address);
    router.replace(`/tracking/${order.id}`);
  }

  return (
    <SafeAreaView style={appStyles.screen}>
      <ScrollView contentContainerStyle={styles.content} showsVerticalScrollIndicator={false}>
        <Animated.View entering={FadeInUp.duration(400)}>
          <View style={styles.header}>
            <ScalePressable onPress={() => router.back()} style={styles.backButton}>
              <Text style={styles.backText}>←</Text>
            </ScalePressable>
            <AppImage uri={XPRESS_LOGO} style={styles.logo} />
            <ScalePressable accessibilityRole="button" accessibilityLabel="Open profile">
              <AppImage uri={SAMPLE_USER.avatar} style={styles.avatar} />
            </ScalePressable>
          </View>
        </Animated.View>

        <Animated.View entering={FadeInUp.duration(400).delay(60)}>
          <Text style={appStyles.screenTitle}>Checkout</Text>
        </Animated.View>

        <Animated.View entering={FadeInUp.duration(500).delay(150).springify().damping(SPRING_CONFIGS.gentle.damping)}>
          <View style={styles.addressCard}>
            <View style={styles.cardHeader}>
              <Text style={appStyles.cardTitle}>Delivery Address</Text>
              <Pill label={SAMPLE_ADDRESS.label} tone="primary" />
            </View>
            <TextInput
              multiline
              onChangeText={setAddress}
              placeholder="Enter delivery address"
              placeholderTextColor={Colors.onSurfaceVariant}
              style={styles.addressInput}
              value={address}
            />
            <ImageBackground source={{ uri: MINI_MAP_IMAGE }} imageStyle={styles.mapImage} style={styles.miniMap}>
              <View style={styles.mapPin}>
                <Text style={styles.mapPinText}>Home</Text>
              </View>
            </ImageBackground>
          </View>
        </Animated.View>

        <Animated.View entering={FadeInUp.duration(500).delay(250).springify().damping(SPRING_CONFIGS.gentle.damping)}>
          <View style={styles.orderCard}>
            <Text style={appStyles.cardTitle}>Order Summary</Text>
            {cart.length === 0 ? (
              <Text style={appStyles.muted}>Your cart is empty. Return to the menu to add items.</Text>
            ) : (
              cart.map(({ item, quantity }) => (
                <View key={item.id} style={styles.summaryItem}>
                  <AppImage uri={item.image} style={styles.itemImage} />
                  <View style={styles.itemBody}>
                    <Text style={styles.itemName}>{item.name}</Text>
                    <Text style={appStyles.muted}>Qty {quantity}</Text>
                  </View>
                  <Text style={styles.itemTotal}>{formatRupiah(item.price * quantity)}</Text>
                </View>
              ))
            )}
          </View>
        </Animated.View>

        <Animated.View entering={FadeInUp.duration(500).delay(350).springify().damping(SPRING_CONFIGS.gentle.damping)}>
          <View style={styles.orderCard}>
            <Text style={appStyles.cardTitle}>Payment Method</Text>
            {paymentMethods.map((method) => (
              <ScalePressable
                key={method}
                scaleTo={0.98}
                onPress={() => setPaymentMethod(method)}
                style={[styles.paymentOption, paymentMethod === method && styles.paymentOptionActive]}>
                <View>
                  <Text style={styles.paymentTitle}>{method}</Text>
                  <Text style={appStyles.muted}>
                    {method === 'E-wallet'
                      ? 'OVO/GoPay Balance: Rp 150.000'
                      : method === 'Credit Card'
                        ? 'Visa ending 2048'
                        : 'Pay when your order arrives'}
                  </Text>
                </View>
                <View style={[styles.radio, paymentMethod === method && styles.radioActive]} />
              </ScalePressable>
            ))}
          </View>
        </Animated.View>

        <Animated.View entering={FadeInUp.duration(500).delay(450).springify().damping(SPRING_CONFIGS.gentle.damping)}>
          <View style={styles.orderCard}>
            <SummaryLine label="Subtotal" value={formatRupiah(subtotal)} />
            <SummaryLine label="Delivery Fee" value={formatRupiah(deliveryFee)} />
            <SummaryLine label="Server Fee" value={formatRupiah(serviceFee)} />
            <View style={appStyles.divider} />
            <SummaryLine label="Total Amount" value={formatRupiah(total)} strong />
          </View>
        </Animated.View>
      </ScrollView>

      <Animated.View entering={SlideInDown.duration(600).delay(500).springify().damping(SPRING_CONFIGS.gentle.damping)}>
        <View style={styles.bottomDrawer}>
          <View>
            <Text style={styles.drawerLabel}>Total Payment</Text>
            <Text style={styles.drawerTotal}>{formatRupiah(total)}</Text>
            <Text style={styles.promoText}>Promo applied: Fresh & Fast</Text>
          </View>
          <AppButton label="Place Order" disabled={!canPlaceOrder} onPress={handlePlaceOrder} />
        </View>
      </Animated.View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  content: {
    ...appStyles.content,
    paddingBottom: 140,
  },
  header: {
    alignItems: 'center',
    flexDirection: 'row',
    justifyContent: 'space-between',
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
  },
  logo: {
    borderRadius: 0,
    height: 24,
    width: 112,
  },
  avatar: {
    borderRadius: BorderRadius.full,
    height: 42,
    width: 42,
  },
  addressCard: {
    ...appStyles.card,
    marginTop: Spacing.sm,
    padding: Spacing.md,
  },
  orderCard: {
    ...appStyles.card,
    gap: Spacing.sm,
    marginTop: 14,
    padding: Spacing.md,
  },
  cardHeader: {
    alignItems: 'center',
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
  addressInput: {
    backgroundColor: Colors.surfaceContainerLow,
    borderColor: Colors.outlineVariant,
    borderRadius: BorderRadius.md,
    borderWidth: 1,
    color: Colors.onSurface,
    fontFamily: 'BeVietnamPro_400Regular',
    fontSize: 14,
    lineHeight: 20,
    marginTop: Spacing.sm,
    minHeight: 76,
    padding: Spacing.sm,
    textAlignVertical: 'top',
  },
  miniMap: {
    alignItems: 'center',
    borderRadius: BorderRadius.lg,
    height: 156,
    justifyContent: 'center',
    marginTop: Spacing.sm,
    overflow: 'hidden',
  },
  mapImage: {
    borderRadius: BorderRadius.lg,
  },
  mapPin: {
    backgroundColor: Colors.brandTerracotta,
    borderRadius: BorderRadius.full,
    paddingHorizontal: 14,
    paddingVertical: Spacing.xs,
  },
  mapPinText: {
    color: Colors.white,
    fontFamily: 'PlusJakartaSans_700Bold',
  },
  summaryItem: {
    alignItems: 'center',
    flexDirection: 'row',
    gap: 10,
  },
  itemImage: {
    borderRadius: BorderRadius.md,
    height: 54,
    width: 54,
  },
  itemBody: {
    flex: 1,
  },
  itemName: {
    ...Typography.labelLg,
    color: Colors.onSurface,
    fontFamily: 'PlusJakartaSans_700Bold',
  },
  itemTotal: {
    ...Typography.labelMd,
    color: Colors.brandTerracotta,
    fontFamily: 'PlusJakartaSans_700Bold',
  },
  paymentOption: {
    alignItems: 'center',
    borderColor: Colors.outlineVariant,
    borderRadius: BorderRadius.md,
    borderWidth: 1,
    flexDirection: 'row',
    justifyContent: 'space-between',
    padding: 14,
  },
  paymentOptionActive: {
    backgroundColor: Colors.secondaryContainer,
    borderColor: Colors.brandTerracotta,
  },
  paymentTitle: {
    ...Typography.labelLg,
    color: Colors.onSurface,
    fontFamily: 'PlusJakartaSans_700Bold',
  },
  radio: {
    borderColor: Colors.outline,
    borderRadius: BorderRadius.full,
    borderWidth: 2,
    height: 20,
    width: 20,
  },
  radioActive: {
    backgroundColor: Colors.brandTerracotta,
    borderColor: Colors.brandTerracotta,
  },
  bottomDrawer: {
    alignItems: 'center',
    backgroundColor: Colors.surfaceContainerLowest,
    borderColor: Colors.outlineVariant,
    borderTopLeftRadius: BorderRadius.xl,
    borderTopRightRadius: BorderRadius.xl,
    borderWidth: 1,
    bottom: 0,
    flexDirection: 'row',
    justifyContent: 'space-between',
    left: 0,
    padding: Spacing.md,
    position: 'absolute',
    right: 0,
    ...Shadows.nav,
  },
  drawerLabel: {
    ...Typography.labelSm,
    color: Colors.onSurfaceVariant,
    fontFamily: 'PlusJakartaSans_600SemiBold',
  },
  drawerTotal: {
    ...Typography.headlineSm,
    color: Colors.onSurface,
  },
  promoText: {
    ...Typography.labelSm,
    color: Colors.brandTerracotta,
    fontFamily: 'PlusJakartaSans_600SemiBold',
  },
});
