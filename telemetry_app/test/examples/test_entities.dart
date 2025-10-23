// test/examples/test_entities.dart

import 'package:telemetry_app/domain/entities/location.dart';
import 'package:telemetry_app/domain/entities/acceleration.dart';
import 'package:telemetry_app/domain/entities/heading.dart';

void main() {
  print(' Testando Entities...\n');
  
  // Teste 1: Location
  print('📍 Testando Location:');
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
  
  print('  - Location 1: $location1');
  print('  - Location 2: $location2');
  print('  - Speed em km/h: ${location1.speedKmh} km/h');
  print('  - É válida: ${location1.isValid}');
  print('  - Distância entre elas: ${location1.distanceTo(location2).toStringAsFixed(2)} metros');
  print('');
  
  // Teste 2: Acceleration
  print('Testando Acceleration:');
  final acceleration = Acceleration(
    x: 2.0,
    y: 3.0,
    z: 9.8, // Gravidade
    timestamp: DateTime.now(),
  );
  
  print('  - Acceleration: $acceleration');
  print('  - Magnitude: ${acceleration.magnitude.toStringAsFixed(2)} m/s²');
  print('  - Sem gravidade: ${acceleration.magnitudeWithoutGravity.toStringAsFixed(2)} m/s²');
  print('  - É significativa: ${acceleration.isSignificant()}');
  print('  - Direção: ${acceleration.direction.toStringAsFixed(0)}°');
  print('');
  
  // Teste 3: Heading
  print(' Testando Heading:');
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
  
  print('  - Heading 1 (0°): $heading1');
  print('  - Heading 2 (90°): $heading2');
  print('  - Heading 3 (225°): $heading3');
  print('  - É válido: ${heading1.isValid}');
  print('  - Diferença entre 0° e 90°: ${heading1.angleDifference(heading2)}°');
  print('');
  
  print('Todos os testes concluídos!');
}