# Dimsum Nuraos Xpress Mobile App

Dimsum Nuraos Xpress is a high-speed, mobile-first marketplace that connects dimsum enthusiasts with local artisanal merchants. Inspired by the Shinkansen motif, the app promises rapid delivery of piping-hot dimsum from bamboo steamer to doorstep.

## 🚀 Tech Stack

- **Framework**: [Expo](https://expo.dev/) (React Native)
- **Routing**: [Expo Router](https://docs.expo.dev/router/introduction/) (File-based routing)
- **Language**: [TypeScript](https://www.typescriptlang.org/)
- **State Management**: React Context API
- **Animations**: [React Native Reanimated](https://docs.swmansion.com/react-native-reanimated/)
- **Fonts**: Plus Jakarta Sans (Headers) & Be Vietnam Pro (Body)

## 📁 Project Structure

- `app/`: Application routes using Expo Router.
- `assets/`: Global assets including fonts and images.
- `components/`: Reusable UI components.
- `constants/`: Design tokens (Colors, Typography) and static data.
- `context/`: Global state management (e.g., CartContext).
- `hooks/`: Custom React hooks.

## 🛠️ Getting Started

### Prerequisites

- [Node.js](https://nodejs.org/) (LTS recommended)
- [npm](https://www.npmjs.com/) or [yarn](https://yarnpkg.com/)
- [Expo Go](https://expo.dev/client) app on your physical device (optional but recommended)

### Installation

1.  **Clone the repository**:
    ```bash
    git clone <repository-url>
    cd dimsumnuraosxpress
    ```

2.  **Install dependencies**:
    ```bash
    npm install
    ```

### Running the App

Start the development server:

```bash
npm start
```

From the Expo CLI, you can open the app on:
- **Android**: Press `a` or run `npm run android` (requires Android Studio / Emulator)
- **iOS**: Press `i` or run `npm run ios` (requires macOS and Xcode / Simulator)
- **Web**: Press `w` or run `npm run web`

## 🎨 Design System

The app follows a strict brand identity:
- **Primary Color**: Terracotta Burnt Orange (`#d35400`)
- **Secondary Color**: Bamboo Wood Brown (`#75584d`)
- **Shapes**: Soft corners (`16px` radius) and pill-shaped interactive elements.
- **Typography**: Modern geometric headers and highly legible body text.

## 📱 Features

- **Home Marketplace**: Browse local dimsum merchants.
- **Merchant Menu**: Explore detailed menus with high-quality imagery.
- **Cart & Checkout**: Seamless ordering experience.
- **Order Tracking**: Real-time status updates from kitchen to delivery.
- **Rating System**: Provide feedback on your culinary experience.

---

Built with ❤️ for Dimsum lovers.
