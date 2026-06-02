import { router, usePathname } from 'expo-router';
import { Pressable, StyleSheet, Text, View } from 'react-native';
import Animated, { SlideInDown, FadeInUp, SlideOutDown, FadeOutDown } from 'react-native-reanimated';

import { AppButton, AppImage, IconButton } from '@/components/AppPrimitives';
import { MinusIcon, PlusIcon } from '@/components/AppIcons';
import { formatRupiah } from '@/constants/Data';
import { Colors, Layout, Shadows, Spacing, Typography } from '@/constants/Theme';
import { useCart } from '@/context/CartContext';
import { SPRING_CONFIGS } from './AnimatedPrimitives';

export function CartPopup() {
  const pathname = usePathname();
  const { cart, itemCount, total, addToCart, decrementItem, removeFromCart } = useCart();

  if (
    itemCount === 0 ||
    pathname.startsWith('/checkout') ||
    pathname.startsWith('/tracking') ||
    pathname.startsWith('/rate')
  ) {
    return null;
  }

  const bottomOffset = pathname.startsWith('/merchant') ? 18 : Layout.cartPopupBottomOffset;
  const previewItems = cart.slice(0, 2);
  const extraCount = Math.max(0, cart.length - previewItems.length);

  return (
    <Animated.View
      entering={SlideInDown.duration(500).springify().damping(SPRING_CONFIGS.gentle.damping).stiffness(SPRING_CONFIGS.gentle.stiffness)}
      exiting={SlideOutDown.duration(400).springify().damping(SPRING_CONFIGS.snappy.damping).stiffness(SPRING_CONFIGS.snappy.stiffness)}
      style={[styles.popup, { bottom: bottomOffset }]}>
      <View style={styles.headerRow}>
        <View>
          <Text style={styles.label}>Your cart</Text>
          <Text style={styles.total}>
            {itemCount} items • {formatRupiah(total)}
          </Text>
        </View>
        <Pressable onPress={() => router.push('/')} style={styles.addMoreButton}>
          <Text style={styles.addMoreText}>Add more</Text>
        </Pressable>
      </View>

      {previewItems.map(({ item, quantity }, index) => (
        <Animated.View 
          key={item.id} 
          entering={FadeInUp.duration(400).delay(100 + index * 60).springify().damping(SPRING_CONFIGS.gentle.damping)}
          exiting={FadeOutDown.duration(300)}
        >
          <View style={styles.itemRow}>
            <AppImage uri={item.image} style={styles.itemImage} />
            <View style={styles.itemBody}>
              <Text numberOfLines={1} style={styles.itemName}>
                {item.name}
              </Text>
              <Text style={styles.itemMeta}>
                {quantity} x {formatRupiah(item.price)}
              </Text>
            </View>
            <View style={styles.quantityRow}>
              <IconButton
                accessibilityLabel="Decrease quantity"
                icon={<MinusIcon color={Colors.brandTerracotta} size={14} />}
                variant="ghost"
                size="sm"
                onPress={() => decrementItem(item.id)}
              />
              <Text style={styles.quantity}>{quantity}</Text>
              <IconButton
                accessibilityLabel="Increase quantity"
                icon={<PlusIcon color={Colors.white} size={14} />}
                size="sm"
                variant="primary"
                onPress={() => addToCart(item)}
              />
            </View>
            <Pressable onPress={() => removeFromCart(item.id)} style={styles.removeButton}>
              <Text style={styles.removeText}>x</Text>
            </Pressable>
          </View>
        </Animated.View>
      ))}

      {extraCount > 0 ? (
        <Text style={styles.moreText}>+{extraCount} more item groups in your cart</Text>
      ) : null}

      <AppButton label="Checkout" onPress={() => router.push('/checkout')} />
    </Animated.View>
  );
}

const styles = StyleSheet.create({
  popup: {
    backgroundColor: Colors.surfaceContainerLowest,
    borderColor: Colors.outlineVariant,
    borderRadius: 24,
    borderWidth: 1,
    gap: Spacing.sm,
    left: Spacing.marginMobile,
    padding: 14,
    position: 'absolute',
    right: Spacing.marginMobile,
    ...Shadows.lg,
  },
  headerRow: {
    alignItems: 'center',
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
  label: {
    ...Typography.labelSm,
    color: Colors.onSurfaceVariant,
    fontFamily: 'PlusJakartaSans_600SemiBold',
    textTransform: 'uppercase',
  },
  total: {
    ...Typography.labelLg,
    color: Colors.onSurface,
    fontFamily: 'PlusJakartaSans_700Bold',
    marginTop: 2,
  },
  addMoreButton: {
    backgroundColor: Colors.secondaryContainer,
    borderRadius: 999,
    paddingHorizontal: 12,
    paddingVertical: 8,
  },
  addMoreText: {
    color: Colors.brandTerracotta,
    fontSize: 12,
    fontFamily: 'PlusJakartaSans_700Bold',
  },
  itemRow: {
    alignItems: 'center',
    flexDirection: 'row',
    gap: 10,
  },
  itemImage: {
    borderRadius: 12,
    height: 48,
    width: 48,
  },
  itemBody: {
    flex: 1,
  },
  itemName: {
    color: Colors.onSurface,
    fontSize: 14,
    fontFamily: 'PlusJakartaSans_700Bold',
  },
  itemMeta: {
    color: Colors.onSurfaceVariant,
    fontSize: 12,
    fontFamily: 'BeVietnamPro_400Regular',
    marginTop: 2,
  },
  quantityRow: {
    alignItems: 'center',
    flexDirection: 'row',
    gap: 8,
  },
  quantity: {
    color: Colors.onSurface,
    fontSize: 15,
    fontFamily: 'PlusJakartaSans_700Bold',
    minWidth: 18,
    textAlign: 'center',
  },
  removeButton: {
    alignItems: 'center',
    height: 28,
    justifyContent: 'center',
    width: 28,
  },
  removeText: {
    color: Colors.error,
    fontSize: 15,
    fontFamily: 'PlusJakartaSans_700Bold',
  },
  moreText: {
    color: Colors.onSurfaceVariant,
    fontSize: 12,
    fontFamily: 'PlusJakartaSans_600SemiBold',
  },
});
