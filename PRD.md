web application/stitch/projects/1081428596892273292/screens/750fbb3e119c47c2903857fabf9eb185
# Dimsum Nuraos Xpress - Flutter Development PRD

## 1. Project Vision
Dimsum Nuraos Xpress is a high-speed dimsum delivery marketplace. The Flutter mobile application serves as the primary interface for users to discover, order, and track artisanal dimsum with an emphasis on speed and "fresh-and-hot" delivery.

## 2. Technical Stack (Flutter Focus)
*   **Framework:** Flutter (Latest Stable)
*   **State Management:** Provider, Riverpod, or BLoC (Recommended for scalability)
*   **Navigation:** GoRouter (Clean handling of deep links for order tracking)
*   **Backend Integration:** REST API or Firebase (Real-time tracking required)
*   **Maps:** `google_maps_flutter` for live order tracking.
*   **Localizations:** `flutter_localizations` (Primary: Bahasa Indonesia, Support: English)

## 3. Brand Identity (Assets)
*   **Logo:** Just Text "Dimsum Nuraos"
*   **Primary Color:** Terracotta (`#d35400`)
*   **Secondary/Surface Colors:** Light blues (`#edf4ff`) and off-whites (`#f7f9ff`)
*   **Typography:** Plus Jakarta Sans

## 4. Key Screens & Features

### 4.1 Home - Beranda ({{DATA:SCREEN:SCREEN_24}})
*   **Features:** Search bar with filters, "Promo Hangat" (Limited offers), "Terlaris" (Best Sellers), "Mitra Terdekat" (Nearby Merchants).
*   **Interactions:** Vertical scroll for marketplace discovery, horizontal scroll for promo banners.

### 4.2 Merchant Menu ({{DATA:SCREEN:SCREEN_12}})
*   **Features:** Category tabs (Signature, Frozen Packs, Beverages), high-fidelity product cards with add-to-cart functionality.
*   **Cart Management:** Bottom persistent cart bar with "Bayar Sekarang" action.

### 4.3 Checkout - Pembayaran ({{DATA:SCREEN:SCREEN_6}})
*   **Features:** Address selection, Order summary (Porsi), Payment method picker (E-wallet, Credit Card, COD), Price breakdown.
*   **Action:** "Pesan Sekarang" with rocket animation logic.

### 4.4 Order Tracking - Pelacakan ({{DATA:SCREEN:SCREEN_33}})
*   **Features:** Real-time Google Maps integration, Driver profile (Budi), Chat/Call quick actions, Estimasi Tiba (ETA) counter.
*   **Real-time:** Map markers must move dynamically based on driver GPS updates.

### 4.5 Rate Experience - Penilaian ({{DATA:SCREEN:SCREEN_22}})
*   **Features:** Dual rating system (Merchant and Driver), custom feedback field, tipping quick-picks (Rp 2.000, Rp 5.000, Custom).

## 5. Non-Functional Requirements
*   **Performance:** Seamless smooth transitions between menu and checkout.
*   **Responsiveness:** Must support various mobile aspect ratios (9:16, 19.5:9).
*   **Offline State:** Graceful handling of connection loss during checkout or tracking.
