import { ReactNode, createContext, useContext, useMemo, useState } from 'react';

import { CartItem, MenuItem, SAMPLE_ADDRESS } from '@/constants/Data';

type OrderStatus = 'preparing' | 'shipping' | 'delivered';
type PaymentMethod = 'E-wallet' | 'Credit Card' | 'Cash on Delivery';

export interface PlacedOrder {
  id: string;
  items: CartItem[];
  subtotal: number;
  deliveryFee: number;
  serviceFee: number;
  total: number;
  address: string;
  paymentMethod: PaymentMethod;
  status: OrderStatus;
  eta: number;
}

interface CartContextValue {
  cart: CartItem[];
  itemCount: number;
  subtotal: number;
  deliveryFee: number;
  serviceFee: number;
  total: number;
  currentOrder: PlacedOrder | null;
  addToCart: (item: MenuItem) => void;
  decrementItem: (itemId: string) => void;
  removeFromCart: (itemId: string) => void;
  clearCart: () => void;
  placeOrder: (paymentMethod: PaymentMethod, address?: string) => PlacedOrder;
  updateOrderStatus: (status: OrderStatus) => void;
}

const DELIVERY_FEE = 12000;
const SERVICE_FEE = 2500;

const CartContext = createContext<CartContextValue | undefined>(undefined);

export function CartProvider({ children }: { children: ReactNode }) {
  const [cart, setCart] = useState<CartItem[]>([]);
  const [currentOrder, setCurrentOrder] = useState<PlacedOrder | null>(null);

  const subtotal = useMemo(
    () => cart.reduce((sum, cartItem) => sum + cartItem.item.price * cartItem.quantity, 0),
    [cart],
  );
  const itemCount = useMemo(
    () => cart.reduce((sum, cartItem) => sum + cartItem.quantity, 0),
    [cart],
  );
  const deliveryFee = cart.length > 0 ? DELIVERY_FEE : 0;
  const serviceFee = cart.length > 0 ? SERVICE_FEE : 0;
  const total = subtotal + deliveryFee + serviceFee;

  function addToCart(item: MenuItem) {
    setCart((items) => {
      const existing = items.find((cartItem) => cartItem.item.id === item.id);

      if (existing) {
        return items.map((cartItem) =>
          cartItem.item.id === item.id
            ? { ...cartItem, quantity: cartItem.quantity + 1 }
            : cartItem,
        );
      }

      return [...items, { item, quantity: 1 }];
    });
  }

  function decrementItem(itemId: string) {
    setCart((items) =>
      items
        .map((cartItem) =>
          cartItem.item.id === itemId
            ? { ...cartItem, quantity: Math.max(0, cartItem.quantity - 1) }
            : cartItem,
        )
        .filter((cartItem) => cartItem.quantity > 0),
    );
  }

  function removeFromCart(itemId: string) {
    setCart((items) => items.filter((cartItem) => cartItem.item.id !== itemId));
  }

  function clearCart() {
    setCart([]);
  }

  function placeOrder(paymentMethod: PaymentMethod, address?: string) {
    const snapshot = [...cart];
    const orderSubtotal = snapshot.reduce(
      (sum, cartItem) => sum + cartItem.item.price * cartItem.quantity,
      0,
    );
    const order: PlacedOrder = {
      id: `DNX-${Date.now().toString().slice(-6)}`,
      items: snapshot,
      subtotal: orderSubtotal,
      deliveryFee: DELIVERY_FEE,
      serviceFee: SERVICE_FEE,
      total: orderSubtotal + DELIVERY_FEE + SERVICE_FEE,
      address: address || `${SAMPLE_ADDRESS.street}, ${SAMPLE_ADDRESS.city}`,
      paymentMethod,
      status: 'preparing',
      eta: 12,
    };

    setCurrentOrder(order);
    setCart([]);

    return order;
  }

  function updateOrderStatus(status: OrderStatus) {
    setCurrentOrder((order) => (order ? { ...order, status } : order));
  }

  const value = useMemo(
    () => ({
      cart,
      itemCount,
      subtotal,
      deliveryFee,
      serviceFee,
      total,
      currentOrder,
      addToCart,
      decrementItem,
      removeFromCart,
      clearCart,
      placeOrder,
      updateOrderStatus,
    }),
    [cart, currentOrder, deliveryFee, itemCount, serviceFee, subtotal, total],
  );

  return <CartContext.Provider value={value}>{children}</CartContext.Provider>;
}

export function useCart() {
  const context = useContext(CartContext);

  if (!context) {
    throw new Error('useCart must be used inside CartProvider');
  }

  return context;
}
