// lib/domain/entities/location.dart

import 'dart:math'; // ← ESTA LINHA RESOLVE TUDO

/// Entidade que representa uma localização
class Location {
  final double latitude;
  final double longitude;
  final double? speed;
  final double? accuracy;
  final DateTime timestamp;
  
  const Location({
    required this.latitude,
    required this.longitude,
    this.speed,
    this.accuracy,
    required this.timestamp,
  });
  
  /// Converte velocidade de m/s para km/h
  double? get speedKmh {
    if (speed == null) return null;
    return speed! * 3.6;
  }
  
  /// Verifica se a localização é válida
  bool get isValid {
    return latitude >= -90 && latitude <= 90 &&
           longitude >= -180 && longitude <= 180;
  }
  
  /// Calcula distância entre duas localizações
  double distanceTo(Location other) {
    const double earthRadius = 6371000;
    
    final double lat1Rad = latitude * (pi / 180);
    final double lat2Rad = other.latitude * (pi / 180);
    final double deltaLatRad = (other.latitude - latitude) * (pi / 180);
    final double deltaLonRad = (other.longitude - longitude) * (pi / 180);
    
    final double a = sin(deltaLatRad / 2) * sin(deltaLatRad / 2) +
                     cos(lat1Rad) * cos(lat2Rad) *
                     sin(deltaLonRad / 2) * sin(deltaLonRad / 2);
    final double c = 2 * asin(sqrt(a));
    
    return earthRadius * c;
  }
  
  @override
  String toString() {
    return 'Location(lat: $latitude, lng: $longitude, speed: $speedKmh km/h)';
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Location &&
           other.latitude == latitude &&
           other.longitude == longitude &&
           other.speed == speed &&
           other.accuracy == accuracy;
  }
  
  @override
  int get hashCode {
    return latitude.hashCode ^
           longitude.hashCode ^
           speed.hashCode ^
           accuracy.hashCode;
  }
}