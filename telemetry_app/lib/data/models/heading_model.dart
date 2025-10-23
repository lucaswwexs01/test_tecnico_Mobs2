import '../../domain/entities/heading.dart';

/// Model para dados de direção 
/// Converte dados brutos da bússola para Entity
class HeadingModel {
  final double degrees;
  final DateTime timestamp;
  
  const HeadingModel({
    required this.degrees,
    required this.timestamp,
  });
  
  /// Converte Model para Entity
  Heading toEntity() {
    return Heading(
      degrees: degrees,
      timestamp: timestamp,
    );
  }
  
  /// Cria Model a partir de dados brutos da bússola
  factory HeadingModel.fromCompassData({
    required double degrees,
  }) {
    return HeadingModel(
      degrees: degrees,
      timestamp: DateTime.now(),
    );
  }
  
  @override
  String toString() {
    return 'HeadingModel($degrees°)';
  }
}