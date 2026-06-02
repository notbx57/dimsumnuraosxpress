import { router } from 'expo-router';
import { StyleSheet, Text, View } from 'react-native';
import Animated, { FadeInUp } from 'react-native-reanimated';

import { AppButton, Pill, ScreenHeader, ScreenShell, appStyles } from '@/components/AppPrimitives';
import { formatRupiah } from '@/constants/Data';
import { Colors, Spacing, Typography } from '@/constants/Theme';
import { useCart } from '@/context/CartContext';

export default function OrdersScreen() {
  const { currentOrder } = useCart();

  return (
    <ScreenShell>
      <Animated.View entering={FadeInUp.duration(400)}>
        <ScreenHeader eyebrow="Orders" title="Track your dimsum" />
      </Animated.View>

      {currentOrder ? (
        <Animated.View entering={FadeInUp.duration(400).delay(120).springify().damping(20)}>
          <View style={styles.orderCard}>
            <View style={styles.headerRow}>
              <Text style={styles.orderId}>{currentOrder.id}</Text>
              <Pill label={currentOrder.status.toUpperCase()} tone="primary" />
            </View>
            <Text style={appStyles.muted}>Dimsum Nuraos Xpress</Text>
            <Text style={styles.total}>{formatRupiah(currentOrder.total)}</Text>
            <Text style={appStyles.muted}>{currentOrder.items.length} item groups ordered</Text>
            <AppButton
              label="Track Order"
              onPress={() => router.push(`/tracking/${currentOrder.id}`)}
            />
          </View>
        </Animated.View>
      ) : (
        <Animated.View entering={FadeInUp.duration(400).delay(120).springify().damping(20)}>
          <View style={styles.orderCard}>
            <Text style={styles.emptyTitle}>No active orders</Text>
            <Text style={appStyles.muted}>Place an order and it will appear here for tracking.</Text>
            <AppButton label="Start Ordering" onPress={() => router.push('/')} />
          </View>
        </Animated.View>
      )}
    </ScreenShell>
  );
}

const styles = StyleSheet.create({
  orderCard: {
    ...appStyles.card,
    gap: Spacing.sm,
    marginTop: Spacing.lg,
    padding: 18,
  },
  headerRow: {
    alignItems: 'center',
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
  orderId: {
    ...Typography.headlineSm,
    color: Colors.onSurface,
  },
  total: {
    ...Typography.headlineLg,
    color: Colors.brandTerracotta,
  },
  emptyTitle: {
    ...Typography.headlineSm,
    color: Colors.onSurface,
  },
});
