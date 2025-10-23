import '../entities/location.dart';
import '../entities/acceleration.dart';
import '../entities/heading.dart';

// Contrato abstrato para o repositório de telemetria
// Define o que podemos fazer com os dados de telemetria
abstract class TelemetryRepository {
  
  // Obtém stream de localização em tempo real
  // Retorna um Stream que emite Location continuamente
  Stream<Location> getCurrentLocation();
  
  // Obtém stream de dados de aceleração em tempo real
  // Retorna um Stream que emite Acceleration continuamente
  Stream<Acceleration> getAccelerationData();
  
  // Obtém stream de direção (bússola) em tempo real
  // Retorna um Stream que emite Heading continuamente
  Stream<Heading> getHeadingData();
  
  // Para todos os streams de telemetria
  // Cancela todas as escutas de dados
  Future<void> stopTelemetry();
  
  // Verifica se as permissões estão concedidas
  ///Retorna true se todas as permissões necessárias estão OK
  Future<bool> hasPermissions();
  
  // Solicita permissões necessárias
  // Retorna true se o usuário concedeu as permissões
  Future<bool> requestPermissions();
}