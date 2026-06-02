import { router, useLocalSearchParams } from 'expo-router';
import { ImageBackground, StyleSheet, Text, View } from 'react-native';
import Animated, { FadeInUp, SlideInDown, ZoomIn } from 'react-native-reanimated';

import { AppButton, AppImage, NavHeader, Pill, ScreenShell, appStyles } from '@/components/AppPrimitives';
import { MAP_IMAGE, SAMPLE_DRIVER, formatRupiah } from '@/constants/Data';
import { BorderRadius, Colors, Shadows, Spacing, Typography } from '@/constants/Theme';
import { useCart } from '@/context/CartContext';
import { SPRING_CONFIGS } from '@/components/AnimatedPrimitives';

export default function TrackingScreen() {
  const { orderId } = useLocalSearchParams<{ orderId: string }>();
  const { currentOrder, updateOrderStatus } = useCart();

  const order = currentOrder?.id === orderId ? currentOrder : currentOrder;

  function completeOrder() {
    updateOrderStatus('delivered');
    router.push(`/rate/${orderId}`);
  }

  return (
    <ScreenShell scrollable={false} edges={['top']}>
      <Animated.View entering={FadeInUp.duration(400)}>
        <NavHeader title="Track Order" onBack={() => router.replace('/(tabs)/orders')} />
      </Animated.View>

      <ImageBackground source={{ uri: MAP_IMAGE }} style={styles.map} resizeMode="cover">
        <View style={styles.routeLine} />
        <Animated.View entering={ZoomIn.duration(500).delay(300).springify().damping(SPRING_CONFIGS.snappy.damping)} style={[styles.pin, styles.merchantPin]}>
          <Text style={styles.pinText}>Dimsum Nuraos</Text>
        </Animated.View>
        <Animated.View entering={ZoomIn.duration(500).delay(500).springify().damping(SPRING_CONFIGS.snappy.damping)} style={[styles.pin, styles.driverPin]}>
          <Text style={styles.pinText}>Budi</Text>
        </Animated.View>
        <Animated.View entering={ZoomIn.duration(500).delay(700).springify().damping(SPRING_CONFIGS.snappy.damping)} style={[styles.pin, styles.userPin]}>
          <Text style={styles.pinText}>Your Home</Text>
        </Animated.View>
      </ImageBackground>

      <Animated.View entering={SlideInDown.duration(600).delay(400).springify().damping(SPRING_CONFIGS.gentle.damping)}>
        <View style={styles.statusCard}>
          <View style={styles.etaRow}>
            <View>
              <Text style={appStyles.muted}>Estimated Arrival</Text>
              <Text style={styles.eta}>{order?.eta || SAMPLE_DRIVER.eta} mins</Text>
            </View>
            <Pill label={order?.status.toUpperCase() || 'PREPARING'} tone="primary" />
          </View>

          <View style={appStyles.divider} />

          <View style={styles.driverRow}>
            <AppImage uri={SAMPLE_DRIVER.image} style={styles.driverImage} />
            <View style={styles.driverBody}>
              <Text style={styles.driverName}>{SAMPLE_DRIVER.name}</Text>
              <Text style={appStyles.muted}>{SAMPLE_DRIVER.plateNumber}</Text>
              <Text style={styles.statusText}>{SAMPLE_DRIVER.status}</Text>
            </View>
          </View>

          {order ? (
            <Text style={styles.totalText}>
              Order {order.id} • {formatRupiah(order.total)}
            </Text>
          ) : null}

          <View style={styles.actions}>
            <AppButton label="Chat" onPress={() => updateOrderStatus('shipping')} />
            <AppButton label="Call" variant="outline" />
          </View>
          <AppButton label="Mark Delivered" onPress={completeOrder} />
        </View>
      </Animated.View>
    </ScreenShell>
  );
}

const styles = StyleSheet.create({
  map: {
    flex: 1,
    overflow: 'hidden',
  },
  routeLine: {
    backgroundColor: Colors.brandTerracotta,
    height: 5,
    left: 74,
    opacity: 0.6,
    position: 'absolute',
    top: '40%',
    transform: [{ rotate: '-18deg' }],
    width: '68%',
  },
  pin: {
    borderRadius: BorderRadius.full,
    paddingHorizontal: Spacing.sm,
    paddingVertical: Spacing.xs,
    position: 'absolute',
    ...Shadows.md,
  },
  merchantPin: {
    backgroundColor: Colors.tertiaryFixed,
    left: 28,
    top: '28%',
  },
  driverPin: {
    backgroundColor: Colors.brandTerracotta,
    left: '48%',
    top: '42%',
  },
  userPin: {
    backgroundColor: Colors.onSurface,
    right: 24,
    top: '58%',
  },
  pinText: {
    color: Colors.white,
    fontFamily: 'PlusJakartaSans_700Bold',
    fontSize: 12,
  },
  statusCard: {
    backgroundColor: Colors.surfaceContainerLowest,
    borderColor: Colors.outlineVariant,
    borderTopLeftRadius: 28,
    borderTopRightRadius: 28,
    borderWidth: 1,
    bottom: 0,
    gap: 14,
    left: 0,
    padding: 18,
    position: 'absolute',
    right: 0,
    ...Shadows.lg,
  },
  etaRow: {
    alignItems: 'center',
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
  eta: {
    ...Typography.headlineLg,
    color: Colors.onSurface,
  },
  driverRow: {
    alignItems: 'center',
    flexDirection: 'row',
    gap: Spacing.sm,
  },
  driverImage: {
    borderRadius: BorderRadius.full,
    height: 64,
    width: 64,
  },
  driverBody: {
    flex: 1,
  },
  driverName: {
    ...Typography.labelLg,
    color: Colors.onSurface,
    fontFamily: 'PlusJakartaSans_700Bold',
  },
  statusText: {
    ...Typography.labelSm,
    color: Colors.brandTerracotta,
    fontFamily: 'PlusJakartaSans_600SemiBold',
    marginTop: 4,
  },
  totalText: {
    ...Typography.labelSm,
    color: Colors.onSurface,
    fontFamily: 'PlusJakartaSans_600SemiBold',
  },
  actions: {
    flexDirection: 'row',
    gap: 10,
  },
});
