import 'package:flutter/material.dart';
import 'package:expense_tracker_app/expenses.dart';

var kColorScheme = ColorScheme.fromSeed(seedColor: const Color(0xff0E5E6F));
var kDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark, seedColor: const Color(0xff0E5E6F));
void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        textTheme: const TextTheme().copyWith(
            titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Poppins',
                color: kDarkColorScheme.onSecondaryContainer),
            titleSmall: TextStyle(
                color: kDarkColorScheme.onSecondaryContainer, fontSize: 16)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kDarkColorScheme.primaryContainer),
        ),
      ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: AppBarTheme(
            foregroundColor: kColorScheme.primaryContainer,
            backgroundColor: kColorScheme.onPrimaryContainer),
        cardTheme: CardTheme().copyWith(
          
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        textTheme: TextTheme().copyWith(
            titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Poppins',
                color: kColorScheme.onSecondaryContainer),
            titleSmall: TextStyle(
                color: kColorScheme.onSecondaryContainer, fontSize: 16)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer),
        ),
      ),
      home: const Expenses(),
    ),
  );
}
