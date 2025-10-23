import 'package:flutter/foundation.dart';
import 'package:telemetry_app/data/models/location_model.dart';
import 'package:telemetry_app/data/models/acceleration.dart';
import 'package:telemetry_app/data/models/heading_model.dart';

void main() {
  debugPrint(' Testando Models...\n');
  
  // Teste 1: LocationModel
  debugPrint(' Testando LocationModel:');
  final locationModel = LocationModel.fromGpsData(
    latitude: -23.5505,
    longitude: -46.6333,
    speed: 10.0, // 10 m/s
    accuracy: 5.0,
  );
  
  debugPrint('  - LocationModel: $locationModel');
  
  // Converter para Entity
  final locationEntity = locationModel.toEntity();
  debugPrint('  - LocationEntity: $locationEntity');
  debugPrint('  - Speed em km/h: ${locationEntity.speedKmh} km/h');
  debugPrint('  - É válida: ${locationEntity.isValid}');
  debugPrint('');
  
  // Teste 2: AccelerationModel
  debugPrint(' Testando AccelerationModel:');
  final accelerationModel = AccelerationModel.fromSensorData(
    x: 2.0,
    y: 3.0,
    z: 9.8, // Gravidade
  );
  
  debugPrint('  - AccelerationModel: $accelerationModel');
  
  // Converter para Entity
  final accelerationEntity = accelerationModel.toEntity();
  debugPrint('  - AccelerationEntity: $accelerationEntity');
  debugPrint('  - Magnitude: ${accelerationEntity.magnitude.toStringAsFixed(2)} m/s²');
  debugPrint('  - Sem gravidade: ${accelerationEntity.magnitudeWithoutGravity.toStringAsFixed(2)} m/s²');
  debugPrint('  - É significativa: ${accelerationEntity.isSignificant()}');
  debugPrint('');
  
  // Teste 3: HeadingModel
  debugPrint(' Testando HeadingModel:');
  final headingModel = HeadingModel.fromCompassData(
    degrees: 225.0, // Sudoeste
  );
  
  debugPrint('  - HeadingModel: $headingModel');
  
  // Converter para Entity
  final headingEntity = headingModel.toEntity();
  debugPrint('  - HeadingEntity: $headingEntity');
  debugPrint('  - Ponto cardeal: ${headingEntity.cardinal}');
  debugPrint('  - É válido: ${headingEntity.isValid}');
  debugPrint('');
  
  // Teste 4: Comparação de dados
  debugPrint(' Testando conversão de dados:');
  
  // Location
  debugPrint('  - LocationModel.latitude: ${locationModel.latitude}');
  debugPrint('  - LocationEntity.latitude: ${locationEntity.latitude}');
  debugPrint('  - Dados iguais: ${locationModel.latitude == locationEntity.latitude}');
  
  // Acceleration
  debugPrint('  - AccelerationModel.x: ${accelerationModel.x}');
  debugPrint('  - AccelerationEntity.x: ${accelerationEntity.x}');
  debugPrint('  - Dados iguais: ${accelerationModel.x == accelerationEntity.x}');
  
  // Heading
  debugPrint('  - HeadingModel.degrees: ${headingModel.degrees}');
  debugPrint('  - HeadingEntity.degrees: ${headingEntity.degrees}');
  debugPrint('  - Dados iguais: ${headingModel.degrees == headingEntity.degrees}');
  debugPrint('');
  
  debugPrint(' Todos os testes de Models concluídos!');
}