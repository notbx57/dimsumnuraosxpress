import { useWindowDimensions } from 'react-native';

import { Layout } from '@/constants/Theme';

const ASPECT_RATIO = Layout.viewportWidth / Layout.viewportHeight;

export function useViewportDimensions() {
  const { width: windowWidth, height: windowHeight } = useWindowDimensions();

  let width = Math.min(windowWidth, Layout.maxViewportWidth);
  let height = width / ASPECT_RATIO;

  if (height > windowHeight) {
    height = windowHeight;
    width = height * ASPECT_RATIO;
  }

  const letterboxHorizontal = Math.max(0, (windowWidth - width) / 2);
  const letterboxVertical = Math.max(0, (windowHeight - height) / 2);
  const isLetterboxed = letterboxHorizontal > 2 || letterboxVertical > 2;

  return {
    width,
    height,
    windowWidth,
    windowHeight,
    isLetterboxed,
  };
}
