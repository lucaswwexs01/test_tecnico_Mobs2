import '../entities/heading.dart';
import '../repositories/telemetry_repository.dart';

/// Use case para obter dados de direção
/// Encapsula a lógica de negócio para obter dados da bússola
class GetHeadingData {
  final TelemetryRepository _repository;
  
  const GetHeadingData(this._repository);
  
  /// Executa o use case e retorna stream de direção
  /// Este método será chamado pelo Provider para obter dados da bússola
  Stream<Heading> call() {
    return _repository.getHeadingData();
  }
}