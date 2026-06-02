import React from 'react';
import { Pressable, ViewStyle, PressableProps } from 'react-native';
import Animated, {
  AnimatedStyle,
  FadeIn as ReanimatedFadeIn,
  FadeInDown as ReanimatedFadeInDown,
  FadeInUp as ReanimatedFadeInUp,
  SlideInDown as ReanimatedSlideInDown,
  SlideInUp as ReanimatedSlideInUp,
  ZoomIn as ReanimatedZoomIn,
  useAnimatedStyle,
  useSharedValue,
  withSpring,
} from 'react-native-reanimated';

// Professional spring configurations
export const SPRING_CONFIGS = {
  gentle: { damping: 20, stiffness: 120, mass: 0.8 },
  snappy: { damping: 15, stiffness: 180, mass: 0.6 },
  bouncy: { damping: 12, stiffness: 150, mass: 1 },
};

const AnimatedPressable = Animated.createAnimatedComponent(Pressable);

interface ScalePressableProps extends PressableProps {
  children: React.ReactNode;
  style?: any;
  scaleTo?: number;
}

export function ScalePressable({
  children,
  style,
  scaleTo = 0.96,
  ...props
}: ScalePressableProps) {
  const scale = useSharedValue(1);

  const animatedStyle = useAnimatedStyle(() => ({
    transform: [{ scale: scale.value }],
  }));

  const handlePressIn = (e: any) => {
    scale.value = withSpring(scaleTo, SPRING_CONFIGS.snappy);
    props.onPressIn?.(e);
  };

  const handlePressOut = (e: any) => {
    scale.value = withSpring(1, SPRING_CONFIGS.snappy);
    props.onPressOut?.(e);
  };

  return (
    <AnimatedPressable
      onPressIn={handlePressIn}
      onPressOut={handlePressOut}
      style={(pressableState: any) => {
        const resolvedStyle = typeof style === 'function' ? style(pressableState) : style;
        return [resolvedStyle, animatedStyle];
      }}
      {...props}
    >
      {children}
    </AnimatedPressable>
  );
}

interface AnimatedFadeInProps {
  delay?: number;
  duration?: number;
  children: React.ReactNode;
  style?: AnimatedStyle<ViewStyle>;
}

export function AnimatedFadeIn({ delay = 0, duration = 400, children, style }: AnimatedFadeInProps) {
  return (
    <Animated.View
      entering={ReanimatedFadeIn.duration(duration).delay(delay)}
      style={style}
    >
      {children}
    </Animated.View>
  );
}

interface AnimatedSlideUpProps {
  delay?: number;
  duration?: number;
  children: React.ReactNode;
  style?: AnimatedStyle<ViewStyle>;
}

export function AnimatedSlideUp({ delay = 0, duration = 500, children, style }: AnimatedSlideUpProps) {
  return (
    <Animated.View
      entering={ReanimatedSlideInUp.duration(duration).delay(delay).springify().damping(SPRING_CONFIGS.gentle.damping).stiffness(SPRING_CONFIGS.gentle.stiffness)}
      style={style}
    >
      {children}
    </Animated.View>
  );
}

interface AnimatedFadeInUpProps {
  delay?: number;
  children: React.ReactNode;
  style?: AnimatedStyle<ViewStyle>;
}

export function AnimatedFadeInUp({ delay = 0, children, style }: AnimatedFadeInUpProps) {
  return (
    <Animated.View
      entering={ReanimatedFadeInUp.duration(500).delay(delay).springify().damping(SPRING_CONFIGS.gentle.damping).stiffness(SPRING_CONFIGS.gentle.stiffness)}
      style={style}
    >
      {children}
    </Animated.View>
  );
}

interface AnimatedFadeInDownProps {
  delay?: number;
  children: React.ReactNode;
  style?: AnimatedStyle<ViewStyle>;
}

export function AnimatedFadeInDown({ delay = 0, children, style }: AnimatedFadeInDownProps) {
  return (
    <Animated.View
      entering={ReanimatedFadeInDown.duration(500).delay(delay).springify().damping(SPRING_CONFIGS.gentle.damping).stiffness(SPRING_CONFIGS.gentle.stiffness)}
      style={style}
    >
      {children}
    </Animated.View>
  );
}

interface AnimatedScaleInProps {
  delay?: number;
  children: React.ReactNode;
  style?: AnimatedStyle<ViewStyle>;
}

export function AnimatedScaleIn({ delay = 0, children, style }: AnimatedScaleInProps) {
  return (
    <Animated.View
      entering={ReanimatedZoomIn.duration(400).delay(delay).springify().damping(SPRING_CONFIGS.snappy.damping).stiffness(SPRING_CONFIGS.snappy.stiffness)}
      style={style}
    >
      {children}
    </Animated.View>
  );
}

interface AnimatedStaggerProps {
  staggerDelay?: number;
  children: React.ReactNode[];
  style?: AnimatedStyle<ViewStyle>;
}

export function AnimatedStagger({ staggerDelay = 80, children, style }: AnimatedStaggerProps) {
  return (
    <Animated.View style={style}>
      {React.Children.map(children, (child, index) => (
        <Animated.View
          entering={ReanimatedFadeInUp.duration(500).delay(index * staggerDelay).springify().damping(SPRING_CONFIGS.gentle.damping).stiffness(SPRING_CONFIGS.gentle.stiffness)}
        >
          {child}
        </Animated.View>
      ))}
    </Animated.View>
  );
}

interface AnimatedSlideDownProps {
  delay?: number;
  children: React.ReactNode;
  style?: AnimatedStyle<ViewStyle>;
}

export function AnimatedSlideDown({ delay = 0, children, style }: AnimatedSlideDownProps) {
  return (
    <Animated.View
      entering={ReanimatedSlideInDown.duration(500).delay(delay).springify().damping(SPRING_CONFIGS.gentle.damping).stiffness(SPRING_CONFIGS.gentle.stiffness)}
      style={style}
    >
      {children}
    </Animated.View>
  );
}

