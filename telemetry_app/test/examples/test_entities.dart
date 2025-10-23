import 'package:flutter/foundation.dart';
import 'package:telemetry_app/domain/entities/location.dart';
import 'package:telemetry_app/domain/entities/acceleration.dart';
import 'package:telemetry_app/domain/entities/heading.dart';

void main() {
  debugPrint('Testando Entities...\n');
  
  // Teste 1: Location
  debugPrint(' Testando Location:');
  final location1 = Location(
    latitude: -23.5505,
    longitude: -46.6333,
    speed: 10.0, // 10 m/s
    accuracy: 5.0,
    timestamp: DateTime.now(),
  );
  
  final location2 = Location(
    latitude: -23.5515,
    longitude: -46.6343,
    speed: 15.0, // 15 m/s
    accuracy: 3.0,
    timestamp: DateTime.now(),
  );
  
  debugPrint('  - Location 1: $location1');
  debugPrint('  - Location 2: $location2');
  debugPrint('  - Speed em km/h: ${location1.speedKmh} km/h');
  debugPrint('  - É válida: ${location1.isValid}');
  debugPrint('  - Distância entre elas: ${location1.distanceTo(location2).toStringAsFixed(2)} metros');
  debugPrint('');
  
  // Teste 2: Acceleration
  debugPrint(' Testando Acceleration:');
  final acceleration = Acceleration(
    x: 2.0,
    y: 3.0,
    z: 9.8, // Gravidade
    timestamp: DateTime.now(),
  );
  
  debugPrint('  - Acceleration: $acceleration');
  debugPrint('  - Magnitude: ${acceleration.magnitude.toStringAsFixed(2)} m/s²');
  debugPrint('  - Sem gravidade: ${acceleration.magnitudeWithoutGravity.toStringAsFixed(2)} m/s²');
  debugPrint('  - É significativa: ${acceleration.isSignificant()}');
  debugPrint('  - Direção: ${acceleration.direction.toStringAsFixed(0)}°');
  debugPrint('');
  
  // Teste 3: Heading
  debugPrint('Testando Heading:');
  final heading1 = Heading(
    degrees: 0.0, // Norte
    timestamp: DateTime.now(),
  );
  
  final heading2 = Heading(
    degrees: 90.0, // Leste
    timestamp: DateTime.now(),
  );
  
  final heading3 = Heading(
    degrees: 225.0, // Sudoeste
    timestamp: DateTime.now(),
  );
  
  debugPrint('  - Heading 1 (0°): $heading1');
  debugPrint('  - Heading 2 (90°): $heading2');
  debugPrint('  - Heading 3 (225°): $heading3');
  debugPrint('  - É válido: ${heading1.isValid}');
  debugPrint('  - Diferença entre 0° e 90°: ${heading1.angleDifference(heading2)}°');
  debugPrint('');
  
  debugPrint('✅ Todos os testes concluídos!');
}