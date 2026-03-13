import 'package:flutter/material.dart';

import '../presentation/screens/camera_screen.dart';
import '../presentation/screens/cart_screen.dart';
import '../presentation/screens/checkout_screen.dart';
import '../presentation/screens/home_screen.dart';
import '../presentation/screens/login_screen.dart';
import '../presentation/screens/order_history_screen.dart';
import '../presentation/screens/product_detail_screen.dart';
import '../presentation/screens/product_list_screen.dart';
import '../presentation/screens/profile_screen.dart';
import '../presentation/screens/register_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String productList = '/products';
  static const String productDetail = '/product-detail';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String orders = '/orders';
  static const String profile = '/profile';
  static const String camera = '/camera';

  static Route<dynamic> generateRoute(
    RouteSettings settings, {
    required VoidCallback toggleTheme,
    required VoidCallback toggleLanguage,
    required Locale locale,
    required void Function(Locale) changeLocale,
    required void Function(int) changePrimaryColor,
    required void Function(int) changeFont,
    required int colorIndex,
    required int fontIndex,
  }) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case productList:
        return MaterialPageRoute(builder: (_) => const ProductListScreen());
      case productDetail:
        return MaterialPageRoute(
          builder: (_) => ProductDetailScreen(
            productId: settings.arguments as String,
          ),
        );
      case cart:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case checkout:
        return MaterialPageRoute(builder: (_) => const CheckoutScreen());
      case orders:
        return MaterialPageRoute(builder: (_) => const OrderHistoryScreen());
      case profile:
        return MaterialPageRoute(
          builder: (_) => ProfileScreen(
            locale: locale,
            onToggleTheme: toggleTheme,
            onChangeLocale: changeLocale,
            colorIndex: colorIndex,
            onChangeColor: changePrimaryColor,
            fontIndex: fontIndex,
            onChangeFont: changeFont,
          ),
        );
      case camera:
        return MaterialPageRoute(
          builder: (_) => const CameraScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
    }
  }
}


