import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/product_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: MaterialApp(
        title: 'Liverpool Store',
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
            primaryColor: const Color(0xFFC8102E),
            appBarTheme: const AppBarTheme(
             backgroundColor: Color(0xFFC8102E),
             foregroundColor: Colors.white,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFFC8102E),
  ),
),

        home: const HomeScreen(),
      ),
    );
  }
}