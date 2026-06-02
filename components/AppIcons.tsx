import { StyleSheet, View } from 'react-native';

import { Colors } from '@/constants/Theme';

interface IconProps {
  color?: string;
  size?: number;
}

const DEFAULT_COLOR = Colors.brandTerracotta;

export function MenuIcon({ color = DEFAULT_COLOR, size = 18 }: IconProps) {
  const lineHeight = Math.max(2, size * 0.12);
  const gap = Math.max(3, size * 0.22);

  return (
    <View style={[styles.menuIcon, { width: size, gap }]}>
      <View style={[styles.menuLine, { backgroundColor: color, height: lineHeight, width: size }]} />
      <View style={[styles.menuLine, { backgroundColor: color, height: lineHeight, width: size * 0.72 }]} />
      <View style={[styles.menuLine, { backgroundColor: color, height: lineHeight, width: size }]} />
    </View>
  );
}

export function SearchIcon({ color = DEFAULT_COLOR, size = 18 }: IconProps) {
  const ring = size * 0.52;

  return (
    <View style={[styles.searchIcon, { height: size, width: size }]}>
      <View
        style={{
          borderColor: color,
          borderRadius: ring / 2,
          borderWidth: Math.max(1.5, size * 0.1),
          height: ring,
          width: ring,
        }}
      />
      <View
        style={{
          backgroundColor: color,
          borderRadius: 999,
          bottom: 1,
          height: Math.max(1.5, size * 0.1),
          position: 'absolute',
          right: 0,
          transform: [{ rotate: '45deg' }],
          width: size * 0.34,
        }}
      />
    </View>
  );
}

export function FilterIcon({ color = DEFAULT_COLOR, size = 18 }: IconProps) {
  const lineHeight = Math.max(1.5, size * 0.11);
  const gap = Math.max(3, size * 0.2);

  return (
    <View style={{ gap, width: size }}>
      <View style={[styles.filterLine, { backgroundColor: color, height: lineHeight, width: size }]} />
      <View
        style={[styles.filterLine, { alignSelf: 'center', backgroundColor: color, height: lineHeight, width: size * 0.62 }]}
      />
      <View
        style={[styles.filterLine, { alignSelf: 'center', backgroundColor: color, height: lineHeight, width: size * 0.42 }]}
      />
    </View>
  );
}

export function PlusIcon({ color = Colors.white, size = 18 }: IconProps) {
  const stroke = Math.max(2, Math.round(size * 0.16));
  const armLength = Math.round(size * 0.58);

  return (
    <View style={[styles.plusIcon, { height: size, width: size }]}>
      <View
        style={{
          backgroundColor: color,
          borderRadius: stroke,
          height: stroke,
          width: armLength,
        }}
      />
      <View
        style={{
          backgroundColor: color,
          borderRadius: stroke,
          height: armLength,
          position: 'absolute',
          width: stroke,
        }}
      />
    </View>
  );
}

export function MinusIcon({ color = DEFAULT_COLOR, size = 18 }: IconProps) {
  const stroke = Math.max(2, Math.round(size * 0.16));
  const armLength = Math.round(size * 0.58);

  return (
    <View style={[styles.plusIcon, { height: size, width: size }]}>
      <View
        style={{
          backgroundColor: color,
          borderRadius: stroke,
          height: stroke,
          width: armLength,
        }}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  menuIcon: {
    justifyContent: 'center',
  },
  menuLine: {
    borderRadius: 999,
  },
  searchIcon: {
    alignItems: 'center',
    justifyContent: 'center',
  },
  filterLine: {
    borderRadius: 999,
  },
  plusIcon: {
    alignItems: 'center',
    justifyContent: 'center',
  },
});
