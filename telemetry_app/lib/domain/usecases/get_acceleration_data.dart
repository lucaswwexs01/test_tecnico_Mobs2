import '../entities/acceleration.dart';
import '../repositories/telemetry_repository.dart';

/// Use case para obter dados de aceleração
/// Encapsula a lógica de negócio para obter dados do acelerômetro
class GetAccelerationData {
  final TelemetryRepository _repository;
  
  const GetAccelerationData(this._repository);
  
  /// Executa o use case e retorna stream de aceleração
  /// Este método será chamado pelo Provider para obter dados do acelerômetro
  Stream<Acceleration> call() {
    return _repository.getAccelerationData();
  }
}