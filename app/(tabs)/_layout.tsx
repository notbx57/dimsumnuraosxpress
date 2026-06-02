import { Tabs } from 'expo-router';
import { StyleSheet, Text, View, Pressable } from 'react-native';
import Animated, { useAnimatedStyle, withSpring, useSharedValue, withTiming, interpolate } from 'react-native-reanimated';
import { useEffect } from 'react';

import { BorderRadius, Colors, Layout, Shadows } from '@/constants/Theme';
import { SPRING_CONFIGS } from '@/components/AnimatedPrimitives';
import { useViewportDimensions } from '@/hooks/useViewportDimensions';

type TabIconName = 'index' | 'orders' | 'profile' | 'home';

function TabIcon({ name, focused }: { name: TabIconName; focused: boolean }) {
  const color = focused ? Colors.brandTerracotta : Colors.outline;

  const animatedStyle = useAnimatedStyle(() => ({
    transform: [{ scale: withSpring(focused ? 1.1 : 1, SPRING_CONFIGS.snappy) }],
  }));

  return (
    <Animated.View style={[styles.iconWrap, animatedStyle]}>
      {name === 'home' || name === 'index' ? (
        <View style={styles.homeIcon}>
          <View style={[styles.homeRoof, { borderBottomColor: color }]} />
          <View style={[styles.homeBody, { backgroundColor: color }]} />
        </View>
      ) : null}
      {name === 'orders' ? (
        <View style={styles.ordersIcon}>
          <View style={[styles.ordersLine, { backgroundColor: color }]} />
          <View style={[styles.ordersLine, styles.ordersLineMid, { backgroundColor: color }]} />
          <View style={[styles.ordersLine, styles.ordersLineShort, { backgroundColor: color }]} />
        </View>
      ) : null}
      {name === 'profile' ? (
        <View style={styles.profileIcon}>
          <View style={[styles.profileHead, { backgroundColor: color }]} />
          <View style={[styles.profileShoulders, { backgroundColor: color }]} />
        </View>
      ) : null}
    </Animated.View>
  );
}

function CustomTabBar({ state, descriptors, navigation }: any) {
  const { width } = useViewportDimensions();
  const tabWidth = width / state.routes.length;
  
  const translateX = useSharedValue(state.index * tabWidth);

  useEffect(() => {
    translateX.value = withSpring(state.index * tabWidth, {
      ...SPRING_CONFIGS.gentle,
      mass: 0.5,
    });
  }, [state.index, tabWidth]);

  const indicatorStyle = useAnimatedStyle(() => ({
    transform: [{ translateX: translateX.value }],
    width: tabWidth,
  }));

  return (
    <View style={styles.tabBar}>
      <Animated.View style={[styles.slidingIndicatorContainer, indicatorStyle]}>
        <View style={styles.indicatorPill} />
      </Animated.View>
      
      {state.routes.map((route: any, index: number) => {
        const { options } = descriptors[route.key];
        const label = options.title !== undefined ? options.title : route.name;
        const isFocused = state.index === index;

        const onPress = () => {
          const event = navigation.emit({
            type: 'tabPress',
            target: route.key,
            canPreventDefault: true,
          });

          if (!isFocused && !event.defaultPrevented) {
            navigation.navigate(route.name);
          }
        };

        return (
          <Pressable
            key={route.key}
            onPress={onPress}
            style={styles.tabItem}
            android_ripple={{ color: 'transparent' }}
          >
            <TabIcon name={route.name as TabIconName} focused={isFocused} />
            <Animated.Text 
              style={[
                styles.tabLabel, 
                { 
                  color: isFocused ? Colors.brandTerracotta : Colors.outline,
                  opacity: withTiming(isFocused ? 1 : 0.7, { duration: 200 }),
                  transform: [{ scale: withSpring(isFocused ? 1.05 : 1, SPRING_CONFIGS.snappy) }]
                }
              ]}
            >
              {label}
            </Animated.Text>
          </Pressable>
        );
      })}
    </View>
  );
}

export default function TabLayout() {
  return (
    <Tabs
      tabBar={(props) => <CustomTabBar {...props} />}
      screenOptions={{
        headerShown: false,
        animation: 'fade', // Subtle fade transition between tab screens
      }}>
      <Tabs.Screen
        name="index"
        options={{
          title: 'Home',
        }}
      />
      <Tabs.Screen
        name="orders"
        options={{
          title: 'Orders',
        }}
      />
      <Tabs.Screen
        name="profile"
        options={{
          title: 'Profile',
        }}
      />
    </Tabs>
  );
}

const styles = StyleSheet.create({
  tabBar: {
    backgroundColor: Colors.surfaceContainerLowest,
    borderColor: Colors.outlineVariant,
    borderTopLeftRadius: BorderRadius.xl,
    borderTopRightRadius: BorderRadius.xl,
    height: Layout.tabBarHeight,
    flexDirection: 'row',
    position: 'absolute',
    bottom: 0,
    left: 0,
    right: 0,
    ...Shadows.nav,
  },
  tabItem: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    paddingBottom: 12,
    paddingTop: 10,
  },
  tabLabel: {
    fontFamily: 'PlusJakartaSans_700Bold',
    fontSize: 11,
    marginTop: 2,
  },
  iconWrap: {
    alignItems: 'center',
    borderRadius: BorderRadius.full,
    height: 32,
    justifyContent: 'center',
    width: 44,
  },
  slidingIndicatorContainer: {
    position: 'absolute',
    top: 10,
    height: 32,
    alignItems: 'center',
    justifyContent: 'center',
  },
  indicatorPill: {
    backgroundColor: Colors.secondaryContainer,
    borderRadius: BorderRadius.full,
    height: 32,
    width: 44,
  },
  homeIcon: {
    alignItems: 'center',
    height: 18,
    justifyContent: 'flex-end',
    width: 20,
  },
  homeRoof: {
    borderBottomWidth: 9,
    borderLeftColor: Colors.transparent,
    borderLeftWidth: 10,
    borderRightColor: Colors.transparent,
    borderRightWidth: 10,
    height: 0,
    marginBottom: 1,
    width: 0,
  },
  homeBody: {
    borderRadius: 2,
    height: 8,
    width: 14,
  },
  ordersIcon: {
    gap: 3,
    width: 18,
  },
  ordersLine: {
    borderRadius: 999,
    height: 2.5,
    width: '100%',
  },
  ordersLineMid: {
    width: '82%',
  },
  ordersLineShort: {
    width: '64%',
  },
  profileIcon: {
    alignItems: 'center',
    height: 18,
    width: 18,
  },
  profileHead: {
    borderRadius: 999,
    height: 7,
    width: 7,
  },
  profileShoulders: {
    borderTopLeftRadius: 8,
    borderTopRightRadius: 8,
    height: 8,
    marginTop: 2,
    width: 14,
  },
});
