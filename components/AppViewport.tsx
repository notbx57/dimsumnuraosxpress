import { StatusBar } from 'expo-status-bar';
import { ReactNode } from 'react';
import { Platform, StyleSheet, View } from 'react-native';

import { useViewportDimensions } from '@/hooks/useViewportDimensions';
import { Colors, Layout, Shadows } from '@/constants/Theme';

interface AppViewportProps {
  children: ReactNode;
}

export function AppViewport({ children }: AppViewportProps) {
  const { width, height, isLetterboxed } = useViewportDimensions();

  return (
    <View style={styles.root}>
      <View
        style={[
          styles.frame,
          {
            width,
            height,
            borderRadius: isLetterboxed ? Layout.frameBorderRadius : 0,
          },
          isLetterboxed && styles.frameLetterboxed,
        ]}>
        <StatusBar style="dark" />
        {children}
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  root: {
    alignItems: 'center',
    backgroundColor: Colors.inverseSurface,
    flex: 1,
    justifyContent: 'center',
    ...(Platform.OS === 'web' && {
      minHeight: '100vh' as unknown as number,
    }),
  },
  frame: {
    backgroundColor: Colors.background,
    overflow: 'hidden',
  },
  frameLetterboxed: {
    borderColor: Colors.outlineVariant,
    borderWidth: 1,
    ...Shadows.lg,
  },
});
