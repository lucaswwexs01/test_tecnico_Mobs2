import '../../domain/entities/location.dart';

/// Model para dados de localização 
/// Converte dados brutos do GPS para Entity
class LocationModel {
  final double latitude;
  final double longitude;
  final double? speed;
  final double? accuracy;
  final DateTime timestamp;
  
  const LocationModel({
    required this.latitude,
    required this.longitude,
    this.speed,
    this.accuracy,
    required this.timestamp,
  });
  
  /// Converte Model para Entity
  Location toEntity() {
    return Location(
      latitude: latitude,
      longitude: longitude,
      speed: speed,
      accuracy: accuracy,
      timestamp: timestamp,
    );
  }
  
  /// Cria Model a partir de dados brutos do GPS
  factory LocationModel.fromGpsData({
    required double latitude,
    required double longitude,
    double? speed,
    double? accuracy,
  }) {
    return LocationModel(
      latitude: latitude,
      longitude: longitude,
      speed: speed,
      accuracy: accuracy,
      timestamp: DateTime.now(),
    );
  }
  
  @override
  String toString() {
    return 'LocationModel(lat: $latitude, lng: $longitude, speed: $speed m/s)';
  }
}