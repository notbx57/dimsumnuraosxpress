import { router } from 'expo-router';
import {
  Image,
  ImageBackground,
  Pressable,
  ScrollView,
  StyleSheet,
  Text,
  TextInput,
  View,
} from 'react-native';
import Animated, { FadeInUp, SlideInDown, SlideInRight } from 'react-native-reanimated';

import { AnimatedFadeIn, AnimatedFadeInUp, ScalePressable, SPRING_CONFIGS } from '@/components/AnimatedPrimitives';
import { FilterIcon, MenuIcon, PlusIcon, SearchIcon } from '@/components/AppIcons';
import { AppImage, IconButton, Pill, ScreenShell, SectionHeader, appStyles } from '@/components/AppPrimitives';
import {
  BEST_SELLERS,
  HERO_IMAGE,
  MERCHANTS,
  MENU_ITEMS,
  RECOMMENDED_FOR_YOU,
  SAMPLE_USER,
  XPRESS_LOGO,
  formatRupiah,
} from '@/constants/Data';
import { Colors, Shadows, Spacing } from '@/constants/Theme';
import { useCart } from '@/context/CartContext';

export default function HomeScreen() {
  const { addToCart } = useCart();
  const heroMerchant = MERCHANTS[0];

  return (
    <ScreenShell>
        <AnimatedFadeIn delay={0}>
          <View style={styles.topBar}>
            <IconButton
              accessibilityLabel="Open menu"
              icon={<MenuIcon color={Colors.brandTerracotta} size={16} />}
              variant="ghost"
            />
            <View style={styles.logoWrap}>
              <Image source={{ uri: XPRESS_LOGO }} resizeMode="contain" style={styles.logo} />
            </View>
            <ScalePressable accessibilityRole="button" accessibilityLabel="Open profile">
              <AppImage uri={SAMPLE_USER.avatar} style={styles.avatar} />
            </ScalePressable>
          </View>
        </AnimatedFadeIn>

        <AnimatedFadeInUp delay={100}>
          <SectionHeader title="Recommended For You" />
        </AnimatedFadeInUp>
        <View style={styles.recommendedVerticalList}>
          {RECOMMENDED_FOR_YOU.map((item, index) => (
            <Animated.View 
              key={item.id} 
              entering={FadeInUp.duration(500).delay(150 + index * 80).springify().damping(SPRING_CONFIGS.gentle.damping)}
            >
              <ScalePressable scaleTo={0.98} style={styles.recommendedLandscapeCard}>
                <View style={styles.landscapeRankBadge}>
                  <Text style={styles.landscapeRankText}>{item.rank}</Text>
                </View>
                <AppImage uri={item.image} style={styles.recommendedLandscapeImage} />
                <View style={styles.recommendedLandscapeBody}>
                  <View style={styles.landscapeInfo}>
                    <Text numberOfLines={1} style={styles.landscapeName}>{item.name}</Text>
                    <Text numberOfLines={1} style={styles.landscapeMerchant}>by {item.merchantName}</Text>
                  </View>
                  <View style={styles.landscapePricing}>
                    <Text style={styles.landscapeDiscountPrice}>{formatRupiah(item.discountPrice)}</Text>
                    <Text style={styles.landscapeOriginalPrice}>{formatRupiah(item.originalPrice)}</Text>
                  </View>
                </View>
              </ScalePressable>
            </Animated.View>
          ))}
        </View>

        <AnimatedFadeIn delay={400}>
          <View style={styles.searchBar}>
            <SearchIcon color={Colors.brandTerracotta} size={18} />
            <TextInput
              placeholder="Search"
              placeholderTextColor={Colors.onSurfaceVariant}
              style={styles.searchInput}
            />
            <View style={styles.searchDivider} />
            <ScalePressable accessibilityLabel="Filter search" accessibilityRole="button" style={styles.filterButton}>
              <FilterIcon color={Colors.brandTerracotta} size={16} />
            </ScalePressable>
          </View>
        </AnimatedFadeIn>

        <AnimatedFadeInUp delay={500}>
          <SectionHeader title="Best Sellers" />
        </AnimatedFadeInUp>
        <ScrollView horizontal showsHorizontalScrollIndicator={false} contentContainerStyle={styles.bestSellerList}>
          {BEST_SELLERS.map((item, index) => {
            const menuItem = MENU_ITEMS.find((product) => product.price === item.price) || MENU_ITEMS[0];

            return (
              <Animated.View 
                key={item.id} 
                entering={FadeInUp.duration(500).delay(600 + index * 80).springify().damping(SPRING_CONFIGS.gentle.damping)}
              >
                <ScalePressable style={styles.bestSellerCard} scaleTo={0.97}>
                  <AppImage uri={item.image} style={styles.bestSellerImage} />
                  <View style={styles.ratingBadge}>
                    <Text style={styles.ratingText}>{item.rating.toFixed(1)}</Text>
                  </View>
                  <Text numberOfLines={1} style={styles.bestSellerName}>
                    {item.name}
                  </Text>
                  <Text numberOfLines={1} style={styles.muted}>
                    {item.merchantName}
                  </Text>
                  <View style={styles.priceRow}>
                    <Text style={styles.price}>{formatRupiah(item.price)}</Text>
                    <IconButton
                      accessibilityLabel="Add to cart"
                      icon={<PlusIcon color={Colors.white} size={14} />}
                      onPress={() => addToCart(menuItem)}
                      variant="primary"
                    />
                  </View>
                </ScalePressable>
              </Animated.View>
            );
          })}
        </ScrollView>

        <AnimatedFadeInUp delay={800}>
          <SectionHeader title="Nearby Merchants" />
        </AnimatedFadeInUp>
        <Animated.View entering={FadeInUp.duration(600).delay(900).springify().damping(SPRING_CONFIGS.gentle.damping)}>
          <ScalePressable style={styles.heroMerchant} scaleTo={0.98} onPress={() => router.push(`/merchant/${heroMerchant.id}`)}>
            <ImageBackground source={{ uri: HERO_IMAGE }} imageStyle={styles.heroImage} style={styles.heroImageWrap}>
              <View style={styles.heroOverlay} />
              <View style={styles.heroBadgeRow}>
                <Pill label={`${heroMerchant.rating} rating`} tone="primary" />
                <Pill label="Favorite" />
              </View>
            </ImageBackground>
            <View style={styles.heroBody}>
              <Text style={styles.heroTitle}>Dimsum Nuraos Xpress</Text>
              <Text style={styles.heroDescription}>{heroMerchant.description}</Text>
              <View style={styles.tagsRow}>
                {heroMerchant.tags.map((tag) => (
                  <Pill key={tag} label={tag} tone="outline" />
                ))}
              </View>
              <View style={styles.merchantFooter}>
                <Text style={styles.distance}>{heroMerchant.distance} away</Text>
                <View style={styles.orderButton}>
                  <Text style={styles.orderButtonText}>Order Now</Text>
                </View>
              </View>
            </View>
          </ScalePressable>
        </Animated.View>

        <View style={styles.secondaryGrid}>
          {MERCHANTS.slice(1).map((merchant, index) => (
            <Animated.View 
              key={merchant.id} 
              entering={FadeInUp.duration(500).delay(1000 + index * 100).springify().damping(SPRING_CONFIGS.gentle.damping)}
              style={styles.secondaryMerchantWrap}
            >
              <ScalePressable 
                style={styles.secondaryMerchant} 
                scaleTo={0.96}
                onPress={() => router.push(`/merchant/${merchant.id}`)}
              >
                <AppImage uri={merchant.image} style={styles.secondaryImage} />
                <Text style={styles.secondaryTitle}>{merchant.name}</Text>
                <Text style={styles.muted}>{merchant.rating} rating</Text>
                <Text style={styles.muted}>{merchant.deliveryFee}</Text>
              </ScalePressable>
            </Animated.View>
          ))}
        </View>
    </ScreenShell>
  );
}

const styles = StyleSheet.create({
  topBar: {
    alignItems: 'center',
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
  logoWrap: {
    alignItems: 'center',
    flex: 1,
    justifyContent: 'center',
    paddingHorizontal: Spacing.sm,
  },
  logo: {
    backgroundColor: Colors.transparent,
    height: 38,
    width: 148,
  },
  avatar: {
    borderRadius: 999,
    height: 42,
    width: 42,
  },
  searchBar: {
    alignItems: 'center',
    backgroundColor: Colors.surfaceContainerLowest,
    borderColor: Colors.outlineVariant,
    borderRadius: 999,
    borderWidth: 1,
    flexDirection: 'row',
    gap: Spacing.sm,
    marginTop: 22,
    overflow: 'hidden',
    paddingLeft: Spacing.md,
    paddingRight: Spacing.xs,
    paddingVertical: 6,
    ...Shadows.sm,
  },
  searchInput: {
    color: Colors.onSurface,
    flex: 1,
    fontFamily: 'BeVietnamPro_400Regular',
    fontSize: 14,
    minHeight: 36,
    minWidth: 0,
    paddingVertical: 4,
  },
  searchDivider: {
    backgroundColor: Colors.outlineVariant,
    height: 22,
    width: 1,
  },
  filterButton: {
    alignItems: 'center',
    borderRadius: 999,
    flexShrink: 0,
    height: 36,
    justifyContent: 'center',
    width: 36,
  },
  recommendedVerticalList: {
    gap: 12,
    marginTop: 2,
  },
  recommendedLandscapeCard: {
    ...appStyles.card,
    borderRadius: 20,
    flexDirection: 'row',
    height: 110,
    overflow: 'hidden',
    padding: 10,
    width: '100%',
  },
  landscapeRankBadge: {
    alignItems: 'center',
    backgroundColor: Colors.white,
    borderColor: Colors.outlineVariant,
    borderRadius: 999,
    borderWidth: 1,
    height: 24,
    justifyContent: 'center',
    left: 6,
    position: 'absolute',
    top: 6,
    width: 24,
    zIndex: 10,
    ...Shadows.sm,
  },
  landscapeRankText: {
    color: Colors.onSurface,
    fontFamily: 'PlusJakartaSans_700Bold',
    fontSize: 10,
  },
  recommendedLandscapeImage: {
    borderRadius: 14,
    height: '100%',
    width: 90,
  },
  recommendedLandscapeBody: {
    flex: 1,
    justifyContent: 'center',
    paddingLeft: 12,
  },
  landscapeInfo: {
    flex: 1,
    justifyContent: 'center',
  },
  landscapeName: {
    color: Colors.onSurface,
    fontFamily: 'PlusJakartaSans_700Bold',
    fontSize: 14,
  },
  landscapeMerchant: {
    color: Colors.onSurfaceVariant,
    fontFamily: 'BeVietnamPro_400Regular',
    fontSize: 11,
    marginTop: 2,
  },
  landscapePricing: {
    alignItems: 'flex-start',
    marginTop: 4,
  },
  landscapeDiscountPrice: {
    color: Colors.brandTerracotta,
    fontFamily: 'PlusJakartaSans_700Bold',
    fontSize: 15,
  },
  landscapeOriginalPrice: {
    color: Colors.onSurfaceVariant,
    fontFamily: 'BeVietnamPro_400Regular',
    fontSize: 10,
    textDecorationLine: 'line-through',
    marginTop: 1,
  },
  bestSellerCard: {
    ...appStyles.card,
    marginRight: 14,
    padding: 12,
    width: 168,
  },
  bestSellerList: {
    paddingRight: Spacing.marginMobile,
  },
  bestSellerImage: {
    borderRadius: 14,
    height: 112,
    width: '100%',
  },
  ratingBadge: {
    alignSelf: 'flex-start',
    backgroundColor: Colors.white,
    borderRadius: 999,
    marginTop: -28,
    paddingHorizontal: 8,
    paddingVertical: 4,
  },
  ratingText: {
    color: Colors.starYellow,
    fontSize: 12,
    fontFamily: 'PlusJakartaSans_700Bold',
  },
  bestSellerName: {
    color: Colors.onSurface,
    fontSize: 15,
    fontFamily: 'PlusJakartaSans_700Bold',
    marginTop: 10,
  },
  muted: {
    ...appStyles.muted,
  },
  priceRow: {
    alignItems: 'center',
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginTop: 10,
  },
  price: {
    color: Colors.brandTerracotta,
    fontSize: 14,
    fontFamily: 'PlusJakartaSans_700Bold',
  },
  heroMerchant: {
    ...appStyles.card,
    overflow: 'hidden',
  },
  heroImageWrap: {
    height: 188,
    justifyContent: 'flex-start',
    padding: 14,
  },
  heroImage: {
    borderTopLeftRadius: 16,
    borderTopRightRadius: 16,
  },
  heroOverlay: {
    ...StyleSheet.absoluteFill,
    backgroundColor: 'rgba(9, 29, 46, 0.18)',
  },
  heroBadgeRow: {
    flexDirection: 'row',
    gap: 8,
  },
  heroBody: {
    padding: 16,
  },
  heroTitle: {
    color: Colors.onSurface,
    fontSize: 24,
    fontFamily: 'PlusJakartaSans_700Bold',
  },
  heroDescription: {
    color: Colors.onSurfaceVariant,
    fontSize: 14,
    fontFamily: 'BeVietnamPro_400Regular',
    lineHeight: 21,
    marginTop: 6,
  },
  tagsRow: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 8,
    marginTop: 12,
  },
  merchantFooter: {
    alignItems: 'center',
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginTop: 16,
  },
  distance: {
    color: Colors.onSurface,
    fontSize: 14,
    fontFamily: 'PlusJakartaSans_600SemiBold',
  },
  orderButton: {
    backgroundColor: Colors.brandTerracotta,
    borderRadius: 999,
    paddingHorizontal: 18,
    paddingVertical: 12,
  },
  orderButtonText: {
    color: Colors.white,
    fontFamily: 'PlusJakartaSans_700Bold',
  },
  secondaryGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 12,
    marginTop: 14,
  },
  secondaryMerchantWrap: {
    flex: 1,
    minWidth: 150,
  },
  secondaryMerchant: {
    ...appStyles.card,
    padding: 10,
    width: '100%',
  },
  secondaryImage: {
    borderRadius: 12,
    height: 86,
    width: '100%',
  },
  secondaryTitle: {
    color: Colors.onSurface,
    fontSize: 14,
    fontFamily: 'PlusJakartaSans_700Bold',
    marginTop: 8,
  },
});
