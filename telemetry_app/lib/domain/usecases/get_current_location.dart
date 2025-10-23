import '../entities/location.dart';
import '../repositories/telemetry_repository.dart';

// Use case para obter localização atual
// Encapsula a lógica de negócio para obter dados de GPS
class GetCurrentLocation {
  final TelemetryRepository _repository;
  
  const GetCurrentLocation(this._repository);
  
  // Executa o use case e retorna stream de localização
  // Este método será chamado pelo Provider para obter dados de GPS
  Stream<Location> call() {
    return _repository.getCurrentLocation();
  }
}