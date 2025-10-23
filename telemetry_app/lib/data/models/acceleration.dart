import '../../domain/entities/acceleration.dart';

/// Model para dados de aceleração 
/// Converte dados brutos do acelerômetro para Entity
class AccelerationModel {
  final double x;
  final double y;
  final double z;
  final DateTime timestamp;
  
  const AccelerationModel({
    required this.x,
    required this.y,
    required this.z,
    required this.timestamp,
  });
  
  /// Converte Model para Entity
  Acceleration toEntity() {
    return Acceleration(
      x: x,
      y: y,
      z: z,
      timestamp: timestamp,
    );
  }
  
  /// Cria Model a partir de dados brutos do acelerômetro
  factory AccelerationModel.fromSensorData({
    required double x,
    required double y,
    required double z,
  }) {
    return AccelerationModel(
      x: x,
      y: y,
      z: z,
      timestamp: DateTime.now(),
    );
  }
  
  @override
  String toString() {
    return 'AccelerationModel(x: $x, y: $y, z: $z m/s²)';
  }
}