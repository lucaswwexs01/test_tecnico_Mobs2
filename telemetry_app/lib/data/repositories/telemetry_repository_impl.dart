import '../../domain/repositories/telemetry_repository.dart';
import '../../domain/entities/location.dart';
import '../../domain/entities/acceleration.dart';
import '../../domain/entities/heading.dart';
import '../datasources/gps_datasource.dart';
import '../datasources/sensor_datasource.dart';
import '../datasources/compass_datasource.dart';
import '../../core/errors/exceptions.dart';

/// Implementação concreta do TelemetryRepository
/// Agrega dados de todos os DataSources e implementa a interface do Domain
class TelemetryRepositoryImpl implements TelemetryRepository {
  
  // Dependências (DataSources)
  final GpsDataSource _gpsDataSource;
  final SensorDataSource _sensorDataSource;
  final CompassDataSource _compassDataSource;
  
  // Construtor com injeção de dependência
  const TelemetryRepositoryImpl({
    required GpsDataSource gpsDataSource,
    required SensorDataSource sensorDataSource,
    required CompassDataSource compassDataSource,
  }) : _gpsDataSource = gpsDataSource,
       _sensorDataSource = sensorDataSource,
       _compassDataSource = compassDataSource;
  
  /// Obtém stream de localização em tempo real
  /// Converte LocationModel para Location Entity
  @override
  Stream<Location> getCurrentLocation() {
    try {
      return _gpsDataSource.getCurrentLocation().map((locationModel) {
        return locationModel.toEntity();
      });
    } catch (e) {
      throw LocationException(
        'Erro no repositório ao obter localização: ${e.toString()}',
        code: 'REPOSITORY_LOCATION_ERROR',
      );
    }
  }
  
  /// Obtém stream de aceleração em tempo real
  /// Converte AccelerationModel para Acceleration Entity
  @override
  Stream<Acceleration> getAccelerationData() {
    try {
      return _sensorDataSource.getAccelerationData().map((accelerationModel) {
        return accelerationModel.toEntity();
      });
    } catch (e) {
      throw SensorException(
        'Erro no repositório ao obter aceleração: ${e.toString()}',
        code: 'REPOSITORY_ACCELERATION_ERROR',
      );
    }
  }
  
  /// Obtém stream de direção em tempo real
  /// Converte HeadingModel para Heading Entity
  @override
  Stream<Heading> getHeadingData() {
    try {
      return _compassDataSource.getHeadingData().map((headingModel) {
        return headingModel.toEntity();
      });
    } catch (e) {
      throw SensorException(
        'Erro no repositório ao obter direção: ${e.toString()}',
        code: 'REPOSITORY_HEADING_ERROR',
      );
    }
  }
  
  /// Para a coleta de dados de telemetria
  /// Cancela todos os streams ativos
  @override
  Future<void> stopTelemetry() async {
    try {
      // Aqui poderíamos implementar lógica para cancelar streams
      // Por enquanto, apenas confirma que foi parado
      // Em uma implementação mais robusta, manteríamos referências aos streams
      // e os cancelaríamos aqui
    } catch (e) {
      throw TelemetryException(
        'Erro ao parar telemetria: ${e.toString()}',
        code: 'STOP_TELEMETRY_ERROR',
      );
    }
  }
  
  /// Verifica se o app tem todas as permissões necessárias
  @override
  Future<bool> hasPermissions() async {
    try {
      // Verifica permissão de localização
      final hasLocationPermission = await _gpsDataSource.hasLocationPermission();
      
      // Verifica se sensores estão disponíveis
      final areSensorsAvailable = await _sensorDataSource.areSensorsAvailable();
      
      // Verifica se magnetômetro está disponível
      final isMagnetometerAvailable = await _compassDataSource.isMagnetometerAvailable();
      
      // Retorna true apenas se tudo estiver OK
      return hasLocationPermission && areSensorsAvailable && isMagnetometerAvailable;
      
    } catch (e) {
      throw PermissionException(
        'Erro ao verificar permissões: ${e.toString()}',
        code: 'PERMISSION_CHECK_ERROR',
      );
    }
  }
  
  /// Solicita todas as permissões necessárias
  @override
  Future<bool> requestPermissions() async {
    try {
      // Solicita permissão de localização
      final locationPermissionGranted = await _gpsDataSource.requestLocationPermission();
      
      // Verifica se sensores estão disponíveis
      final areSensorsAvailable = await _sensorDataSource.areSensorsAvailable();
      
      // Verifica se magnetômetro está disponível
      final isMagnetometerAvailable = await _compassDataSource.isMagnetometerAvailable();
      
      // Retorna true apenas se tudo foi concedido/disponível
      return locationPermissionGranted && areSensorsAvailable && isMagnetometerAvailable;
      
    } catch (e) {
      throw PermissionException(
        'Erro ao solicitar permissões: ${e.toString()}',
        code: 'PERMISSION_REQUEST_ERROR',
      );
    }
  }
  
  /// Métodos auxiliares para verificação individual
  
  /// Verifica se GPS está habilitado
  Future<bool> isGpsEnabled() async {
    try {
      return await _gpsDataSource.isGpsEnabled();
    } catch (e) {
      throw LocationException(
        'Erro ao verificar status do GPS: ${e.toString()}',
        code: 'GPS_STATUS_ERROR',
      );
    }
  }
  
  /// Obtém localização atual (uma única vez)
  Future<Location> getCurrentPosition() async {
    try {
      final locationModel = await _gpsDataSource.getCurrentPosition();
      return locationModel.toEntity();
    } catch (e) {
      throw LocationException(
        'Erro ao obter posição atual: ${e.toString()}',
        code: 'CURRENT_POSITION_ERROR',
      );
    }
  }
  
  /// Obtém aceleração atual (uma única vez)
  Future<Acceleration> getCurrentAcceleration() async {
    try {
      final accelerationModel = await _sensorDataSource.getCurrentAcceleration();
      return accelerationModel.toEntity();
    } catch (e) {
      throw SensorException(
        'Erro ao obter aceleração atual: ${e.toString()}',
        code: 'CURRENT_ACCELERATION_ERROR',
      );
    }
  }
  
  /// Obtém direção atual (uma única vez)
  Future<Heading> getCurrentHeading() async {
    try {
      final headingModel = await _compassDataSource.getCurrentHeading();
      return headingModel.toEntity();
    } catch (e) {
      throw SensorException(
        'Erro ao obter direção atual: ${e.toString()}',
        code: 'CURRENT_HEADING_ERROR',
      );
    }
  }
}