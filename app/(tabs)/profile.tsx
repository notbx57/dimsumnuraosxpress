import { StyleSheet, Text, View } from 'react-native';
import Animated, { FadeInUp } from 'react-native-reanimated';

import { AppImage, Pill, ScreenHeader, ScreenShell, appStyles } from '@/components/AppPrimitives';
import { SAMPLE_ADDRESS, SAMPLE_USER } from '@/constants/Data';
import { Colors, Spacing } from '@/constants/Theme';

export default function ProfileScreen() {
  return (
    <ScreenShell>
      <Animated.View entering={FadeInUp.duration(400)}>
        <ScreenHeader eyebrow="Profile" title="Delivery-ready account" />
      </Animated.View>

      <Animated.View entering={FadeInUp.duration(400).delay(120).springify().damping(20)}>
        <View style={styles.profileCard}>
          <AppImage uri={SAMPLE_USER.avatar} style={styles.avatar} />
          <View style={styles.profileText}>
            <Text style={appStyles.cardTitle}>{SAMPLE_USER.name}</Text>
            <Text style={appStyles.muted}>Dimsum enthusiast</Text>
          </View>
          <Pill label="VIP" tone="primary" />
        </View>
      </Animated.View>

      <Animated.View entering={FadeInUp.duration(400).delay(200).springify().damping(20)}>
        <View style={styles.infoCard}>
          <Text style={appStyles.sectionEyebrow}>Default Address</Text>
          <Text style={styles.infoStrong}>{SAMPLE_ADDRESS.label}</Text>
          <Text style={appStyles.muted}>
            {SAMPLE_ADDRESS.street}, {SAMPLE_ADDRESS.city}
          </Text>
        </View>
      </Animated.View>

      <Animated.View entering={FadeInUp.duration(400).delay(280).springify().damping(20)}>
        <View style={styles.infoCard}>
          <Text style={appStyles.sectionEyebrow}>Payment</Text>
          <Text style={styles.infoStrong}>OVO / GoPay Balance</Text>
          <Text style={appStyles.muted}>Rp 150.000 available for checkout simulation.</Text>
        </View>
      </Animated.View>
    </ScreenShell>
  );
}

const styles = StyleSheet.create({
  profileCard: {
    ...appStyles.card,
    alignItems: 'center',
    flexDirection: 'row',
    gap: 14,
    marginTop: Spacing.lg,
    padding: Spacing.md,
  },
  avatar: {
    borderRadius: 999,
    height: 72,
    width: 72,
  },
  profileText: {
    flex: 1,
  },
  infoCard: {
    ...appStyles.card,
    marginTop: 14,
    padding: Spacing.md,
  },
  infoStrong: {
    ...appStyles.cardTitle,
    fontSize: 18,
  },
});
