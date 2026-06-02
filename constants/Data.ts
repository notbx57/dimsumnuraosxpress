/**
 * Dimsum Nuraos Xpress — Dummy Data
 * All menu items, merchants, promos, and sample orders.
 */

// ─── Menu Items ─────────────────────────────────────────────
export interface MenuItem {
  id: string;
  name: string;
  nameZh: string;
  price: number;
  description: string;
  image: string;
  rating: number;
  category: 'signature' | 'frozen' | 'beverage';
  merchantId: string;
}

export const MENU_ITEMS: MenuItem[] = [
  {
    id: 'item-1',
    name: 'Ayam',
    nameZh: '鸡',
    price: 25000,
    description: 'Classic chicken steamed dumplings with savory broth.',
    image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuC8zRB7fnGTSyEiCsaA3XXGHgstmE3StecrJJWiVpg1awbnuj_-etsJsuBbmRqQC1aawrBo4h3DERWxdYeXPh2TiVZ7RodVheFWy7Xw9NLqnnR85WzWMU18V6FSOmGp-HqtOLqvyHl94lFf_YlsiJlRQ46547t6XCxMaLJruAzViqOdgIcZA-ly5SGvQIt2z4crYcszJvYb-fGQsT25jMQIzrczYVuwJ9cs66BG5ji3DF9VovYvpbd5DAltrz-Y50WK8-2OKJD6cU0',
    rating: 4.9,
    category: 'signature',
    merchantId: 'merchant-1',
  },
  {
    id: 'item-2',
    name: 'Beef',
    nameZh: '牛',
    price: 28000,
    description: 'Premium wagyu beef blend with aromatic Chinese spices.',
    image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCKZw8Eufa3_e1QhhaEek5J-_8lp4bvW38Q_NV03V9-Fxgsrh00hWRXjad_s8-UqVflErt9qBigdOty6zTEQmtZXJZXheXj8czv6R4QTc0wNjNODB72yUDeQmHB8HC0yQgJxq2j6sMwEETrRmfVuR1x_rZZSH6bePzrt3hf1wPbrXAUQz0m7WJ6XQel02kFxqeH_oJ-C5zMBiZltpUPQHf_nt2aDU_ujhT6xo4yDDVWKRv-EMwmRgzxyfltq7wRZAC9jQ40HuG1TAI',
    rating: 4.8,
    category: 'signature',
    merchantId: 'merchant-1',
  },
  {
    id: 'item-3',
    name: 'Udang',
    nameZh: '虾',
    price: 32000,
    description: 'Plump, whole fresh shrimp wrapped in crystal skin.',
    image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCi4pQhFrCXDBWosMQxYLUsg3K5Do5A_DB_HLQiyeBU6bQRkfFoBXb5qst8VKWkXD3HjA9Zxff2mkE3lo36iHs2iaIw-yVY9Psru5Gq7YsnJHnUrNg9Y-NDKT2JgnOHJl86O8yGHXErou-DV89WBKva10LF-oeDPYMNKBu3dVb1eAIo83uhSczY4C80xdHs0zNW2QxDezbLLZaFssYBv8sGme8sioWGUg8pbz72jQsv3U71SWJ0o2Q1e35SNb2w1QiZY-xrSIBZGtA',
    rating: 4.7,
    category: 'signature',
    merchantId: 'merchant-1',
  },
  {
    id: 'item-4',
    name: 'Keju',
    nameZh: '芝士',
    price: 30000,
    description: 'Melting mozzarella fusion with traditional chicken base.',
    image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCIG5ZsaZWVqSnlSJ5zngYOFAJx1hTOPxiZa6o3qS9e6XyBdoJ6VipYgy6arQmxxdBXK00qkmGVt4UC0_5a6ct6HgCKIpU8fBoEygNJzrVqC0Ebm39aYB8tIcnbtvtpqlYbB_xp6mc8m9weAUab6O_YXAUGBerUE-mDJxa56TUsI3u3evWmnxkZgdYy1g684QWupQ1RDrKGrESpvioiBmmzf6EwX2_1hsH9tKX9VYl89hbeHoHBpgBAQZSscVB9BqFnFqEsWBbGBM8',
    rating: 4.6,
    category: 'signature',
    merchantId: 'merchant-1',
  },
  {
    id: 'item-5',
    name: 'Frozen Ayam Pack',
    nameZh: '冷冻鸡',
    price: 75000,
    description: '12 pieces of classic chicken dimsum. Ready to steam at home.',
    image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDRiZcQvE42wn0W6GvNyYzce3EkVh6BJ9SrmGBDotAQQOIAJ6JZ3syfnhEQSrXepe0S1e3snXyXP0iv3j7NHDp9TEu8FLB2RigtgknmaUzZy1aVskWnaBR4f-jRJWp8FuhNfLP7tKws3um9bmKPebYF7JLBcnB1fjT03348hoZolCWgN7pF7xM3Kg1GNSSC9p0BcOvF_amV1T05D2BFu7MZBldnO7LZEcmIIpmpFhP7Pw8HD7gF5CxvblTGUwHo8WWUwmYB9mWPmRw',
    rating: 4.8,
    category: 'frozen',
    merchantId: 'merchant-1',
  },
  {
    id: 'item-6',
    name: 'Frozen Udang Pack',
    nameZh: '冷冻虾',
    price: 90000,
    description: '12 pieces of premium shrimp dimsum. Ready to steam at home.',
    image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCujCzKCpy0mOStvUqevVVzDnfR-rMhbNKBNFIx9EEP5uiNwT07KUza6rY8LxgAzqlEoLsMB2tnonhESc4oEgt4Y6ABjigsHqS943C-YiIlNEtadjZWYIPpXHLOWw3t0Lqa7gvNHGatbXihSgMtMHZGTrSbOXtnhnjc8ud8eh1BzZBVBGuZFXj0Xb-k2VAnfYN60KPHx1_aGx0rnjwnpVY6t_VqGacFxAea2AwlQ1nbI8TdcQX7YCDdak4AHTjTXfInXNd6Et0kVrc',
    rating: 4.7,
    category: 'frozen',
    merchantId: 'merchant-1',
  },
  {
    id: 'item-7',
    name: 'Family Bundle Pack',
    nameZh: '全家福',
    price: 145000,
    description: '24 assorted pieces: Ayam, Beef, Udang, and Keju.',
    image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuD8uVW4KbsPFtT7ZihWVazX_IBPV_QnlUL8_Ri0YZmWsK9JwMK4xnQvo-6RSqTJpZ-JDh1_rraneVZT-33TbpICV6aYvl1VyMg-IqniAsTshmzUblpez99H-zeZTYdTXySuDmKBkSMVnFiHA53Oj2EL5Vdu3couOla6IQtBhbk9punZqopa9QvOUD64uoPn6cFL0MpNaqbTEGmuwpIpif4HJeK7F8-sbvNSWbvzj6O78xMemy35xvvMC82UJIQ_yqGxftbXL0KjIwM',
    rating: 4.9,
    category: 'frozen',
    merchantId: 'merchant-1',
  },
  {
    id: 'item-8',
    name: 'Teh Jasmine',
    nameZh: '茉莉花茶',
    price: 12000,
    description: 'Fragrant jasmine green tea, hot or cold.',
    image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAfbZ7sF8QF2OYcMDPZrQNZqvRDdjbLTdlFyfjyvkpMeoaR2ysAMAuT7E6svTWGhJ3tsQ4IkjWwAH2LdWg2YpZiu9sLCtLGhkDb767RpIAY4r2sdtRa4DHD3lwlt0lnnY9fbT5MXMLlLC-_km6QIVVMHvjWgSdHOr15Ule08Nw_OUJjEvJsA-b3HIzTZRU-mmuvGMpwIqLOO2uQpFyXbrwt0zNPDXDCz9MzjCjXToyopWe3r8-QMlTbeCF1TbGF90xIlQYoTatKGuI',
    rating: 4.5,
    category: 'beverage',
    merchantId: 'merchant-1',
  },
];

// ─── Merchants ──────────────────────────────────────────────
export interface Merchant {
  id: string;
  name: string;
  subtitle: string;
  description: string;
  image: string;
  rating: number;
  reviewCount: string;
  deliveryTime: string;
  distance: string;
  tags: string[];
  priceTier: string;
  deliveryFee: string;
}

export const MERCHANTS: Merchant[] = [
  {
    id: 'merchant-1',
    name: 'Dimsum Nuraos',
    subtitle: 'Artisanal Dimsum',
    description: 'Artisanal bamboo-steamed dimsum with premium fillings. Famous for their 4 signature variants: Chicken, Beef, Shrimp, and Cheese.',
    image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuD8uVW4KbsPFtT7ZihWVazX_IBPV_QnlUL8_Ri0YZmWsK9JwMK4xnQvo-6RSqTJpZ-JDh1_rraneVZT-33TbpICV6aYvl1VyMg-IqniAsTshmzUblpez99H-zeZTYdTXySuDmKBkSMVnFiHA53Oj2EL5Vdu3couOla6IQtBhbk9punZqopa9QvOUD64uoPn6cFL0MpNaqbTEGmuwpIpif4HJeK7F8-sbvNSWbvzj6O78xMemy35xvvMC82UJIQ_yqGxftbXL0KjIwM',
    rating: 4.8,
    reviewCount: '2k+',
    deliveryTime: '15-25 min',
    distance: '0.8 km',
    tags: ['Fast Delivery', 'HALAL', 'Authentic'],
    priceTier: '$$',
    deliveryFee: 'Free Delivery',
  },
  {
    id: 'merchant-2',
    name: 'Hao Chi Dimsum',
    subtitle: 'Dumplings & Bao',
    description: 'Traditional Cantonese dumplings and bao buns, made fresh daily.',
    image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCkzfvu51S9v3BpC8jZ2IroBqjO142BEju76xA07iPmV9wbkS2qNGryAjQ8wNBUEaNtcAC0D7AbDfJImCC2GvNIzAwA-TKm2RuqUfNkc17yLk2mEq0bl7VDfUABpqautXtYPsk9Di3qXqD5khk1Weg7QOeAi0QS99MR3hlZef3jH2iMm2h3uFHmFu3cjQ5sO7WnfuK5mFv0KcdOj2ZRdD4iNXQSDfVHA86eU6F4ZSmKxghx9ig003MFowjRw3XU4bv3QbQEmsRJfYs',
    rating: 4.5,
    reviewCount: '800+',
    deliveryTime: '20-35 min',
    distance: '1.2 km',
    tags: ['Best Value', 'Traditional'],
    priceTier: '$',
    deliveryFee: 'Low Delivery Fee',
  },
  {
    id: 'merchant-3',
    name: 'Golden Steam',
    subtitle: 'Modern Cantonese',
    description: 'A modern take on Cantonese dim sum. Crystal dumplings and gyoza.',
    image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAfbZ7sF8QF2OYcMDPZrQNZqvRDdjbLTdlFyfjyvkpMeoaR2ysAMAuT7E6svTWGhJ3tsQ4IkjWwAH2LdWg2YpZiu9sLCtLGhkDb767RpIAY4r2sdtRa4DHD3lwlt0lnnY9fbT5MXMLlLC-_km6QIVVMHvjWgSdHOr15Ule08Nw_OUJjEvJsA-b3HIzTZRU-mmuvGMpwIqLOO2uQpFyXbrwt0zNPDXDCz9MzjCjXToyopWe3r8-QMlTbeCF1TbGF90xIlQYoTatKGuI',
    rating: 4.7,
    reviewCount: '1.5k+',
    deliveryTime: '15-20 min',
    distance: '0.5 km',
    tags: ['Premium', 'HALAL', 'New Menu'],
    priceTier: '$$',
    deliveryFee: 'Free Delivery',
  },
];

// ─── Promos ─────────────────────────────────────────────────
export interface Promo {
  id: string;
  title: string;
  subtitle: string;
  tag: string;
  tagColor: string;
  image: string;
}

export const PROMOS: Promo[] = [
  {
    id: 'promo-1',
    title: 'Discount 20% on Chicken Dimsum',
    subtitle: 'Valid until midnight • Dimsum Nuraos',
    tag: 'LIMITED OFFER',
    tagColor: '#9e3d00',
    image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDRiZcQvE42wn0W6GvNyYzce3EkVh6BJ9SrmGBDotAQQOIAJ6JZ3syfnhEQSrXepe0S1e3snXyXP0iv3j7NHDp9TEu8FLB2RigtgknmaUzZy1aVskWnaBR4f-jRJWp8FuhNfLP7tKws3um9bmKPebYF7JLBcnB1fjT03348hoZolCWgN7pF7xM3Kg1GNSSC9p0BcOvF_amV1T05D2BFu7MZBldnO7LZEcmIIpmpFhP7Pw8HD7gF5CxvblTGUwHo8WWUwmYB9mWPmRw',
  },
  {
    id: 'promo-2',
    title: 'Premium Shrimp Siomay',
    subtitle: 'Try our new recipe today!',
    tag: 'NEW ARRIVAL',
    tagColor: '#8c7042',
    image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCujCzKCpy0mOStvUqevVVzDnfR-rMhbNKBNFIx9EEP5uiNwT07KUza6rY8LxgAzqlEoLsMB2tnonhESc4oEgt4Y6ABjigsHqS943C-YiIlNEtadjZWYIPpXHLOWw3t0Lqa7gvNHGatbXihSgMtMHZGTrSbOXtnhnjc8ud8eh1BzZBVBGuZFXj0Xb-k2VAnfYN60KPHx1_aGx0rnjwnpVY6t_VqGacFxAea2AwlQ1nbI8TdcQX7YCDdak4AHTjTXfInXNd6Et0kVrc',
  },
  {
    id: 'promo-3',
    title: 'Family Bundle — Save 20%',
    subtitle: 'Perfect for weekend gatherings',
    tag: 'BEST VALUE',
    tagColor: '#71582c',
    image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuABT6gTv3uMZNt2531ri4xz03yUHZPJJ8oUtpshnxsYU8hmlG6ecS5ikZVvRmhB2a8U80IhIhjPCvYpWuwqCfF3JLWHlaoK7V4Gb0sCeLiuO0S5Y6NA8wO_mxqR-FLvcvz3iT1uKcedySmn44f_2YhybBR53ryDngQSVlU3SbYp-8w_eiEw2oT6JPB4UEcCYYi9OYMiiQQDpeD5_i6lMEgBveT5pOU5O1RjA_GluecekcKyykgD4dIRv0t44HngyYu4U7zmmrUdkxI',
  },
];

// ─── Best Sellers ────────────────────────────────────────────
export interface BestSeller {
  id: string;
  name: string;
  merchantName: string;
  price: number;
  image: string;
  rating: number;
}

export const BEST_SELLERS: BestSeller[] = [
  {
    id: 'bs-1',
    name: 'Siomay Ayam Special',
    merchantName: 'Dimsum Nuraos',
    price: 25000,
    image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDRiZcQvE42wn0W6GvNyYzce3EkVh6BJ9SrmGBDotAQQOIAJ6JZ3syfnhEQSrXepe0S1e3snXyXP0iv3j7NHDp9TEu8FLB2RigtgknmaUzZy1aVskWnaBR4f-jRJWp8FuhNfLP7tKws3um9bmKPebYF7JLBcnB1fjT03348hoZolCWgN7pF7xM3Kg1GNSSC9p0BcOvF_amV1T05D2BFu7MZBldnO7LZEcmIIpmpFhP7Pw8HD7gF5CxvblTGUwHo8WWUwmYB9mWPmRw',
    rating: 4.9,
  },
  {
    id: 'bs-2',
    name: 'Hakau Udang',
    merchantName: 'Golden Steam',
    price: 32000,
    image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCujCzKCpy0mOStvUqevVVzDnfR-rMhbNKBNFIx9EEP5uiNwT07KUza6rY8LxgAzqlEoLsMB2tnonhESc4oEgt4Y6ABjigsHqS943C-YiIlNEtadjZWYIPpXHLOWw3t0Lqa7gvNHGatbXihSgMtMHZGTrSbOXtnhnjc8ud8eh1BzZBVBGuZFXj0Xb-k2VAnfYN60KPHx1_aGx0rnjwnpVY6t_VqGacFxAea2AwlQ1nbI8TdcQX7YCDdak4AHTjTXfInXNd6Et0kVrc',
    rating: 4.8,
  },
  {
    id: 'bs-3',
    name: 'Beef Dimsum',
    merchantName: 'Hao Chi Dimsum',
    price: 28000,
    image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCkzfvu51S9v3BpC8jZ2IroBqjO142BEju76xA07iPmV9wbkS2qNGryAjQ8wNBUEaNtcAC0D7AbDfJImCC2GvNIzAwA-TKm2RuqUfNkc17yLk2mEq0bl7VDfUABpqautXtYPsk9Di3qXqD5khk1Weg7QOeAi0QS99MR3hlZef3jH2iMm2h3uFHmFu3cjQ5sO7WnfuK5mFv0KcdOj2ZRdD4iNXQSDfVHA86eU6F4ZSmKxghx9ig003MFowjRw3XU4bv3QbQEmsRJfYs',
    rating: 4.7,
  },
];

// ─── Recommended ─────────────────────────────────────────────
export interface RecommendedItem {
  id: string;
  name: string;
  merchantName: string;
  originalPrice: number;
  discountPrice: number;
  image: string;
  rank: string;
}

export const RECOMMENDED_FOR_YOU: RecommendedItem[] = [
  {
    id: 'rec-1',
    name: 'Dimsum Mentai 4pcs',
    merchantName: 'EciDimsum',
    originalPrice: 20000,
    discountPrice: 15000,
    image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuC8zRB7fnGTSyEiCsaA3XXGHgstmE3StecrJJWiVpg1awbnuj_-etsJsuBbmRqQC1aawrBo4h3DERWxdYeXPh2TiVZ7RodVheFWy7Xw9NLqnnR85WzWMU18V6FSOmGp-HqtOLqvyHl94lFf_YlsiJlRQ46547t6XCxMaLJruAzViqOdgIcZA-ly5SGvQIt2z4crYcszJvYb-fGQsT25jMQIzrczYVuwJ9cs66BG5ji3DF9VovYvpbd5DAltrz-Y50WK8-2OKJD6cU0',
    rank: '1st',
  },
  {
    id: 'rec-2',
    name: 'Dimsum Frozen 100pcs',
    merchantName: 'Dimsum Ratu',
    originalPrice: 200000,
    discountPrice: 195000,
    image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDRiZcQvE42wn0W6GvNyYzce3EkVh6BJ9SrmGBDotAQQOIAJ6JZ3syfnhEQSrXepe0S1e3snXyXP0iv3j7NHDp9TEu8FLB2RigtgknmaUzZy1aVskWnaBR4f-jRJWp8FuhNfLP7tKws3um9bmKPebYF7JLBcnB1fjT03348hoZolCWgN7pF7xM3Kg1GNSSC9p0BcOvF_amV1T05D2BFu7MZBldnO7LZEcmIIpmpFhP7Pw8HD7gF5CxvblTGUwHo8WWUwmYB9mWPmRw',
    rank: '2nd',
  },
  {
    id: 'rec-3',
    name: 'Gyoza 4pcs Ori',
    merchantName: 'GyozaMania',
    originalPrice: 22000,
    discountPrice: 17000,
    image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCujCzKCpy0mOStvUqevVVzDnfR-rMhbNKBNFIx9EEP5uiNwT07KUza6rY8LxgAzqlEoLsMB2tnonhESc4oEgt4Y6ABjigsHqS943C-YiIlNEtadjZWYIPpXHLOWw3t0Lqa7gvNHGatbXihSgMtMHZGTrSbOXtnhnjc8ud8eh1BzZBVBGuZFXj0Xb-k2VAnfYN60KPHx1_aGx0rnjwnpVY6t_VqGacFxAea2AwlQ1nbI8TdcQX7YCDdak4AHTjTXfInXNd6Et0kVrc',
    rank: '3rd',
  },
];

// ─── Sample Order ────────────────────────────────────────────
export interface CartItem {
  item: MenuItem;
  quantity: number;
}

export const SAMPLE_CART: CartItem[] = [
  { item: MENU_ITEMS[0], quantity: 2 },
  { item: MENU_ITEMS[3], quantity: 1 },
];

export interface OrderSummary {
  items: CartItem[];
  subtotal: number;
  deliveryFee: number;
  serviceFee: number;
  total: number;
}

export const SAMPLE_ORDER: OrderSummary = {
  items: SAMPLE_CART,
  subtotal: 80000, // 2×25000 + 1×30000
  deliveryFee: 12000,
  serviceFee: 2500,
  total: 94500,
};

// ─── Delivery Address ────────────────────────────────────────
export interface DeliveryAddress {
  label: string;
  street: string;
  city: string;
}

export const SAMPLE_ADDRESS: DeliveryAddress = {
  label: 'Home',
  street: 'Jl. Mawar Indah No. 42',
  city: 'Kebayoran Lama, Jakarta Selatan 12240',
};

// ─── Driver Info ─────────────────────────────────────────────
export interface Driver {
  name: string;
  plateNumber: string;
  image: string;
  status: string;
  eta: number;
}

export const SAMPLE_DRIVER: Driver = {
  name: 'Budi',
  plateNumber: 'T 1987 BC',
  image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDX2IxKCdUuMcHsCt5uCkIObUOtVZwXEp829CmrSkQyCe-Mccxy9vUkasca0ZCvTDS2J8Pgkr-F0j8WG1YWTB7JPNargl-CRr8dJqjYTGfD_gL4IMYq8Uz9eqq7c9zbya3RTcjWKoT4LNB50rEkrucIJ3fn5sae_ZuDxTA4c4EGxCEstWtdYg4YrT0lwZgcTV4o9gQAUbKpT6lqccY2xm6vp10AGmkWnqPvyCHAF7hLItrBbj1UWV5S_E83Da6vzBhUjJReRooyXwY',
  status: 'Driver is picking up your dimsum',
  eta: 12,
};

// ─── User Profile ────────────────────────────────────────────
export interface UserProfile {
  name: string;
  avatar: string;
}

export const SAMPLE_USER: UserProfile = {
  name: 'Sarah',
  avatar: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDmOhSUHhtjN3qgyn34sJd00AhR8M7OFfoIVdkW-uRhDFquwFNk1Py82vt8-D2wIe6p-uuVmOuqWzCAv_LeXDHXtbGSxLF-o1lgsBPe-KonUXcBhpktDEO4skRRpbK4Grc2qlSRrWq-_nYBRN3vh2iEhEnP60hp_Wphp7Y8WvuMwkVdSRBTlEdXFIpsukyXt5t_SV5Ji2ZpzRlxnwbic36ois3H9c_ggpUF0d5ziYLWXDs2wOi8biO302d7jWrSHpaZCqEyASFamrI',
};

// ─── Helpers ─────────────────────────────────────────────────
export function formatRupiah(amount: number): string {
  return `Rp ${amount.toLocaleString('id-ID')}`;
}

// Brand logo URL
export const XPRESS_LOGO = 'https://lh3.googleusercontent.com/aida-public/AB6AXuDgBOatJxg9KCSF81O4CxbvJBtzpxgHNbm6P2p9mEZvjXZpt0RQh7-SHmrzG2dUiG6WXkvWGg-v26rq4WEKxQhzxEQqfDTGQ8ej4GaA34AHDlhQ_7e5MYfFH6fqmLu6KolurSe3_xGGCMb6Il5mbLus4jcYdxPxWtClx0UnjtD1NuhcjxUWkyG8Hv5EcbMm0kRwUbIGJ7-eFEcHRh1CVeqmxxZaVzbKsG2gw9-UWF9h2KvDBoussS2lt6B1KIdXKnUiD5LVGFF0SUA';

export const HERO_IMAGE = 'https://lh3.googleusercontent.com/aida-public/AB6AXuABT6gTv3uMZNt2531ri4xz03yUHZPJJ8oUtpshnxsYU8hmlG6ecS5ikZVvRmhB2a8U80IhIhjPCvYpWuwqCfF3JLWHlaoK7V4Gb0sCeLiuO0S5Y6NA8wO_mxqR-FLvcvz3iT1uKcedySmn44f_2YhybBR53ryDngQSVlU3SbYp-8w_eiEw2oT6JPB4UEcCYYi9OYMiiQQDpeD5_i6lMEgBveT5pOU5O1RjA_GluecekcKyykgD4dIRv0t44HngyYu4U7zmmrUdkxI';

export const MAP_IMAGE = 'https://lh3.googleusercontent.com/aida-public/AB6AXuBN7bGl4LefwBLwdEAhBD406B5RlUjbJcy5MzX_8z5cta544Ll7H1TRt3xOtk1aI1TDUowfH_YJ-pHPJg0WGi73tlCkuDAwfGaiNRYXDyH4d9Mf89Dwur0086UNHN7pONlt-HK2ZvWlwcF7JK3Ss5AfUz7pRKqvwhanrRyh0VNYkp51ah4uSC6M4jSEIdnWU8n7vTzUUWzGoKZAAUeL3NVrEdvwQk4H-1O1ajApI1_Pc5YuR8Tc6oT9bYQaJyFcaXpTlQ_q32OfCfU';

export const STEAMER_HERO = 'https://lh3.googleusercontent.com/aida-public/AB6AXuAgh5zp7MUICR_WN98H-ZiWfuO7GsONP5A9CLZE1EidqP1RnDkwScPcodbLCiy_e7PTmWmxxF1RymUc8YN0IzTu4MoanDQ9HzWrLTXFpj-L6h3-a_Dtj7wffacK-Dc4W5rR5UrLK9v5OLcw3crm1JWSIdOYjdRzQiv1wNPg8LIVpImZPqOXb5yKrZjOLT33LA_s956HMFv-OQ0SeLeAMuAECJX86oS1ltYCdaQWYyoKTJZNURSqsN4EvKQkrqwEDawqCBs99Fr3DS8';

export const MINI_MAP_IMAGE = 'https://lh3.googleusercontent.com/aida-public/AB6AXuDPaPCmEtL_4HGMNsyTyYRt8jioTxdmiC08FUvBODgtW2wV0oDX6uas2maF1C2fakZYZdxM_l87cBo5Ys-t6PL1hIuhtT_dAQ-H9s52UGtDQNHwqvHvY3ln_fnchtLSCeZQLmg27dU1O4HlJhytBahRqLh9Zkrr8S3Kkj-6H82orQX3TzWZFQFFqTBjutbt8akehXn2I_7hxoKimVXsbMvGRj6-FPMfXi6Dd37QBOflVrDYuW6XbyxfiBG3usYUjjI1wbdnIr3LP04';
