import 'package:flutter/material.dart';

import 'ui/screens.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.purple,
      secondary: Colors.deepOrange,
      background: Colors.white,
      surfaceTint: Colors.grey[200],
    );

    final themeData = ThemeData(
       fontFamily: 'Lato',
        colorScheme: colorScheme,
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 4,
          shadowColor: colorScheme.shadow,
        ),
      // Thêm định nghĩa dialogTheme vào ThemeData
      dialogTheme: DialogTheme(
        titleTextStyle: TextStyle(
          color: colorScheme.onBackground,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        contentTextStyle: TextStyle(
          color: colorScheme.onBackground,
          fontSize: 20,
        ),
      ),
    );

    return MaterialApp(
      title: 'MyShop',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: const ProductsOverviewScreen(),
        routes: {
          CartScreen.routeName: (ctx) => const SafeArea(
            child: CartScreen(),
          ),
          OrdersScreen.routeName: (ctx) => const SafeArea(
            child: OrdersScreen(),
          ),
          UserProductsScreen.routeName: (ctx) => const SafeArea(
            child: UserProductsScreen(),
          ),
        },

        onGenerateRoute: (settings) {
          if (settings.name == ProductDetailScreen.routeName) {
            final productId = settings.arguments as String;
            return MaterialPageRoute(
              settings: settings,
              builder: (ctx) {
                return SafeArea(
                  child: ProductDetailScreen(
                    ProductsManager().findById(productId)!,
                  ),
                );
              },
            );
          }
          return null;
        },
    );
  }
}
