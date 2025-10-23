import 'package:flutter/foundation.dart';
import 'package:telemetry_app/domain/entities/location.dart';
import 'package:telemetry_app/domain/entities/acceleration.dart';
import 'package:telemetry_app/domain/entities/heading.dart';
import 'package:telemetry_app/domain/repositories/telemetry_repository.dart';
import 'package:telemetry_app/domain/usecases/get_current_location.dart';
import 'package:telemetry_app/domain/usecases/get_acceleration_data.dart';
import 'package:telemetry_app/domain/usecases/get_heading_data.dart';

/// Mock Repository para testar os Use Cases
class MockTelemetryRepository implements TelemetryRepository {
  @override
  Stream<Location> getCurrentLocation() {
    // Simula dados de GPS
    return Stream.periodic(
      const Duration(seconds: 1),
      (count) => Location(
        latitude: -23.5505 + (count * 0.0001), // Simula movimento
        longitude: -46.6333 + (count * 0.0001),
        speed: 10.0 + (count * 0.5), // Simula aceleração
        accuracy: 5.0,
        timestamp: DateTime.now(),
      ),
    );
  }

  @override
  Stream<Acceleration> getAccelerationData() {
    // Simula dados do acelerômetro
    return Stream.periodic(
      const Duration(milliseconds: 100),
      (count) => Acceleration(
        x: 2.0 + (count % 3 - 1) * 0.5, // Simula movimento
        y: 3.0 + (count % 2 - 0.5) * 0.3,
        z: 9.8 + (count % 4 - 2) * 0.2, // Gravidade + variação
        timestamp: DateTime.now(),
      ),
    );
  }

  @override
  Stream<Heading> getHeadingData() {
    // Simula dados da bússola
    return Stream.periodic(
      const Duration(milliseconds: 500),
      (count) => Heading(
        degrees: (count * 10) % 360, // Simula rotação
        timestamp: DateTime.now(),
      ),
    );
  }

  @override
  Future<void> stopTelemetry() async {
    debugPrint('Mock: Telemetria parada');
  }

  @override
  Future<bool> hasPermissions() async {
    return true; // Simula permissões concedidas
  }

  @override
  Future<bool> requestPermissions() async {
    return true; // Simula permissões concedidas
  }
}

void main() async {
  debugPrint(' Testando Use Cases...\n');
  
  // Criar mock repository
  final mockRepository = MockTelemetryRepository();
  
  // Criar use cases
  final getCurrentLocation = GetCurrentLocation(mockRepository);
  final getAccelerationData = GetAccelerationData(mockRepository);
  final getHeadingData = GetHeadingData(mockRepository);
  
  // Teste 1: Verificar permissões
  debugPrint(' Testando permissões:');
  final hasPermissions = await mockRepository.hasPermissions();
  final requestPermissions = await mockRepository.requestPermissions();
  debugPrint('  - Tem permissões: $hasPermissions');
  debugPrint('  - Solicitar permissões: $requestPermissions');
  debugPrint('');
  
  // Teste 2: Use Case - GetCurrentLocation
  debugPrint(' Testando GetCurrentLocation:');
  final locationStream = getCurrentLocation.call();
  await for (final location in locationStream.take(3)) {
    debugPrint('  - Location: $location');
  }
  debugPrint('');
  
  // Teste 3: Use Case - GetAccelerationData
  debugPrint(' Testando GetAccelerationData:');
  final accelerationStream = getAccelerationData.call();
  await for (final acceleration in accelerationStream.take(3)) {
    debugPrint('  - Acceleration: $acceleration');
  }
  debugPrint('');
  
  // Teste 4: Use Case - GetHeadingData
  debugPrint(' Testando GetHeadingData:');
  final headingStream = getHeadingData.call();
  await for (final heading in headingStream.take(3)) {
    debugPrint('  - Heading: $heading');
  }
  debugPrint('');
  
  // Teste 5: Parar telemetria
  debugPrint(' Testando stopTelemetry:');
  await mockRepository.stopTelemetry();
  debugPrint('');
  
  debugPrint('Todos os testes de Use Cases concluídos!');
}