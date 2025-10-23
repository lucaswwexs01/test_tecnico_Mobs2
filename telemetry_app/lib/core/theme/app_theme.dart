// lib/core/theme/app_theme.dart

import 'package:flutter/material.dart';
import 'colors.dart';

/// Tema principal do app
class AppTheme {
  
  /// Tema claro
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
      ),
      
      // Configurações do AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,        // #5438ac
        foregroundColor: AppColors.textPrimary,    // Branco
        elevation: 2,
        centerTitle: true,
      ),
      
      // Configurações de botões
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,     // #5438ac
          foregroundColor: AppColors.textPrimary,   // Branco
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      
      // Configurações de cards
      cardTheme: CardThemeData(
        color: AppColors.cardBackground,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      
      // Configurações de texto
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: AppColors.textPrimary,            // Branco
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: AppColors.textPrimary,            // Branco
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          color: AppColors.textPrimary,            // Branco
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: AppColors.textSecondary,          // #5d4b7c
          fontSize: 14,
        ),
      ),
    );
  }
}