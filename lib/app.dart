import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/cart_repository.dart';
import 'data/repositories/order_repository.dart';
import 'data/repositories/product_repository.dart';
import 'data/services/auth_service.dart';
import 'data/services/cart_service.dart';
import 'data/services/order_service.dart';
import 'data/services/product_service.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/providers/cart_provider.dart';
import 'presentation/providers/order_provider.dart';
import 'presentation/providers/product_provider.dart';
import 'presentation/screens/splash_screen.dart';
import 'routes/app_routes.dart';

class CoffeeApp extends StatefulWidget {
  const CoffeeApp({super.key});

  @override
  State<CoffeeApp> createState() => _CoffeeAppState();
}

class _CoffeeAppState extends State<CoffeeApp> {
  ThemeMode _themeMode = ThemeMode.dark;
  Locale _locale = const Locale('en');
  int _colorIndex = 0;
  int _fontIndex = 0;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  void _toggleLanguage() {
    setState(() {
      if (_locale.languageCode == 'en') {
        _locale = const Locale('km');
      } else if (_locale.languageCode == 'km') {
        _locale = const Locale('zh');
      } else {
        _locale = const Locale('en');
      }
    });
  }

  void _setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  void _setColor(int index) {
    setState(() {
      _colorIndex = index;
    });
  }

  void _setFont(int index) {
    setState(() {
      _fontIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Instantiate services and repositories once at the top level.
    final authRepository = AuthRepository(AuthService());
    final productRepository = ProductRepository(ProductService());
    final cartRepository = CartRepository(CartService());
    final orderRepository = OrderRepository(OrderService());

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(authRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductProvider(productRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(cartRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderProvider(orderRepository),
        ),
      ],
      child: Builder(
        builder: (context) {
          final primaryColors = <Color>[
            Colors.orange,
            Colors.brown,
            Colors.teal,
          ];
          final fontFamilies = <String?>[
            null, // default
            'Georgia',
            'Courier',
          ];
          final primary = primaryColors[_colorIndex % primaryColors.length];
          final fontFamily = fontFamilies[_fontIndex % fontFamilies.length];

          final lightTheme =
              AppTheme.buildLightTheme(primary, fontFamily: fontFamily);
          final darkTheme =
              AppTheme.buildDarkTheme(primary, fontFamily: fontFamily);

          return MaterialApp(
            title: 'Coffee App',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: _themeMode,
            locale: _locale,
            onGenerateRoute: (settings) => AppRoutes.generateRoute(
              settings,
              toggleTheme: _toggleTheme,
              toggleLanguage: _toggleLanguage,
              locale: _locale,
              changeLocale: _setLocale,
              changePrimaryColor: _setColor,
              changeFont: _setFont,
              colorIndex: _colorIndex,
              fontIndex: _fontIndex,
            ),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}


