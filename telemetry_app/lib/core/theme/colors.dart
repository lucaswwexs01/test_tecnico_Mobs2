// lib/core/theme/colors.dart

import 'package:flutter/material.dart';

/// Paleta de cores do app
class AppColors {
  // Cores principais 
  static const Color primary = Color(0xFF5438AC);      // #5438ac - Roxo principal
  static const Color secondary = Color(0xFF261055);    // #261055 - Roxo escuro
  static const Color accent = Color(0xFF5337AB);       // #5337ab - Roxo médio
  
  // Cores de status
  static const Color success = Color(0xFF4CAF50);       // Verde (mantido)
  static const Color warning = Color(0xFFFF9800);       // Laranja (mantido)
  static const Color error = Color(0xFFF44336);         // Vermelho (mantido)
  static const Color info = Color(0xFF5438AC);          // Usando sua cor principal
  
  // Cores de fundo
  static const Color background = Color(0xFFF5F5F5);   // Cinza claro (mantido)
  static const Color surface = Color(0xFFFFFFFF);      // Branco (mantido)
  static const Color cardBackground = Color(0xFFFFFFFF); // Branco (mantido)
  
  // Cores de texto
  static const Color textPrimary = Color(0xFFFFFFFF);   // Branco (sua preferência)
  static const Color textSecondary = Color(0xFF5D4B7C);  // #5d4b7c - Roxo claro para texto secundário
  static const Color textHint = Color(0xFFBDBDBD);       // Cinza claro (mantido)
  
  // Cores específicas para telemetria
  static const Color speedColor = Color(0xFF4CAF50);    // Verde para velocidade (mantido)
  static const Color accelerationColor = Color(0xFFFF9800); // Laranja para aceleração (mantido)
  static const Color headingColor = Color(0xFF5438AC);  // Sua cor principal para direção
  static const Color mapColor = Color(0xFF261055);      // Sua cor escura para mapa
  
  // Cores adicionais 
  static const Color purpleLight = Color(0xFF5D4B7C);   // #5d4b7c - Roxo claro
  static const Color purpleMedium = Color(0xFF5337AB);  // #5337ab - Roxo médio
  static const Color purpleDark = Color(0xFF261055);    // #261055 - Roxo escuro
  static const Color purplePrimary = Color(0xFF5438AC); // #5438ac - Roxo principal
}