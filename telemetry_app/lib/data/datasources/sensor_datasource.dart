import 'package:sensors_plus/sensors_plus.dart';
import '../models/acceleration.dart';
import '../../core/errors/exceptions.dart';

/// DataSource responsável por coletar dados de aceleração
/// Usa o pacote sensors_plus para acessar acelerômetro em tempo real
class SensorDataSource {
  
  /// Obtém stream de dados de aceleração em tempo real
  /// Retorna um `Stream<AccelerationModel>` que emite atualizações contínuas
  Stream<AccelerationModel> getAccelerationData() {
    try {
      // Retorna stream do acelerômetro
      return accelerometerEventStream().map((AccelerometerEvent event) {
        // Converte AccelerometerEvent (sensors_plus) para AccelerationModel
        return AccelerationModel.fromSensorData(
          x: event.x, // Aceleração no eixo X (m/s²)
          y: event.y, // Aceleração no eixo Y (m/s²)
          z: event.z, // Aceleração no eixo Z (m/s²)
        );
      });
      
    } catch (e) {
      // Se der erro, lança exceção personalizada
      throw SensorException(
        'Erro ao obter dados de aceleração: ${e.toString()}',
        code: 'ACCELEROMETER_ERROR',
      );
    }
  }
  
  /// Verifica se os sensores estão disponíveis no dispositivo
  Future<bool> areSensorsAvailable() async {
    try {
      // Tenta obter um evento do acelerômetro para testar
      final subscription = accelerometerEventStream().listen((event) {
        // Se conseguiu obter dados, os sensores estão funcionando
      });
      
      // Cancela a subscription imediatamente (só era para testar)
      await subscription.cancel();
      
      return true;
      
    } catch (e) {
      // Se deu erro, os sensores não estão disponíveis
      return false;
    }
  }
  
  /// Obtém dados de aceleração uma única vez
  Future<AccelerationModel> getCurrentAcceleration() async {
    try {
      // Escuta apenas o primeiro evento do stream
      final event = await accelerometerEventStream().first;
      
      return AccelerationModel.fromSensorData(
        x: event.x,
        y: event.y,
        z: event.z,
      );
      
    } catch (e) {
      throw SensorException(
        'Erro ao obter aceleração atual: ${e.toString()}',
        code: 'CURRENT_ACCELERATION_ERROR',
      );
    }
  }
  
  /// Filtra dados de aceleração significativos
  /// Remove dados muito pequenos (ruído) e mantém apenas movimentos relevantes
  Stream<AccelerationModel> getSignificantAcceleration({
    double threshold = 1.0, // m/s²
  }) {
    try {
      return accelerometerEventStream()
          .map((AccelerometerEvent event) {
            return AccelerationModel.fromSensorData(
              x: event.x,
              y: event.y,
              z: event.z,
            );
          })
          .where((AccelerationModel model) {
            // Filtra apenas acelerações significativas
            final entity = model.toEntity();
            return entity.isSignificant(threshold: threshold);
          });
          
    } catch (e) {
      throw SensorException(
        'Erro ao filtrar aceleração significativa: ${e.toString()}',
        code: 'SIGNIFICANT_ACCELERATION_ERROR',
      );
    }
  }
  
  /// Obtém dados de giroscópio (rotação)
  /// Útil para detectar rotações do dispositivo
  Stream<GyroscopeEvent> getGyroscopeData() {
    try {
      return gyroscopeEventStream();
    } catch (e) {
      throw SensorException(
        'Erro ao obter dados do giroscópio: ${e.toString()}',
        code: 'GYROSCOPE_ERROR',
      );
    }
  }
  
  /// Obtém dados de magnetômetro (bússola)
  /// Útil para detectar direção magnética
  Stream<MagnetometerEvent> getMagnetometerData() {
    try {
      return magnetometerEventStream();
    } catch (e) {
      throw SensorException(
        'Erro ao obter dados do magnetômetro: ${e.toString()}',
        code: 'MAGNETOMETER_ERROR',
      );
    }
  }
}