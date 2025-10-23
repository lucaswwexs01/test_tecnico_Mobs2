// lib/core/utils/formatters.dart

import 'dart:math';

/// Utilitários para formatação de dados
class AppFormatters {
  
  /// Converte m/s para km/h
  static double metersPerSecondToKmh(double mps) {
    return mps * 3.6;
  }
  
  /// Converte km/h para m/s
  static double kmhToMetersPerSecond(double kmh) {
    return kmh / 3.6;
  }
  
  /// Converte graus para pontos cardeais
  static String degreesToCardinal(double degrees) {
    const List<String> cardinals = [
      'N', 'NNE', 'NE', 'ENE', 'E', 'ESE', 'SE', 'SSE',
      'S', 'SSO', 'SO', 'OSO', 'O', 'ONO', 'NO', 'NNO'
    ];
    
    int index = ((degrees + 11.25) / 22.5).floor() % 16;
    return cardinals[index];
  }
  
  /// Formata velocidade com 1 casa decimal
  static String formatSpeed(double speed) {
    return '${speed.toStringAsFixed(1)} km/h';
  }
  
  /// Formata aceleração com 2 casas decimais
  static String formatAcceleration(double acceleration) {
    return '${acceleration.toStringAsFixed(2)} m/s²';
  }
  
  /// Formata direção com graus e ponto cardeal
  static String formatHeading(double degrees) {
    return '${degrees.toStringAsFixed(0)}° ${degreesToCardinal(degrees)}';
  }
  
  /// Calcula a magnitude da aceleração (x, y, z)
  static double calculateAccelerationMagnitude(double x, double y, double z) {
    return sqrt(x * x + y * y + z * z);
  }
}