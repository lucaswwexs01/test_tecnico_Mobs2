
/// Entidade que representa a direção (bússola)
/// É como um "molde" para dados da bússola
class Heading {
  // Propriedades (dados que a entidade guarda)
  final double degrees; // Direção em graus (0-360)
  final DateTime timestamp; // Quando foi coletado
  
  // Construtor (como criar uma nova direção)
  const Heading({
    required this.degrees,
    required this.timestamp,
  });
  
  // Métodos (o que podemos fazer com uma direção)
  
  /// Converte graus para pontos cardeais
  /// Exemplo: 0° = Norte, 90° = Leste, 180° = Sul, 270° = Oeste
  String get cardinal {
    const List<String> cardinals = [
      'N', 'NNE', 'NE', 'ENE', 'E', 'ESE', 'SE', 'SSE',
      'S', 'SSO', 'SO', 'OSO', 'O', 'ONO', 'NO', 'NNO'
    ];
    
    // Calcula qual ponto cardeal baseado nos graus
    int index = ((degrees + 11.25) / 22.5).floor() % 16;
    return cardinals[index];
  }
  
  /// Normaliza os graus para 0-360
  /// Se tiver -10°, vira 350°
  /// Se tiver 370°, vira 10°
  double get normalizedDegrees {
    double normalized = degrees % 360;
    if (normalized < 0) normalized += 360;
    return normalized;
  }
  
  /// Verifica se a direção é válida
  /// Deve estar entre 0 e 360 graus
  bool get isValid {
    return degrees >= 0 && degrees <= 360;
  }
  
  /// Calcula a diferença angular entre duas direções
  /// Exemplo: 10° e 350° = diferença de 20° (não 340°)
  double angleDifference(Heading other) {
    double diff = (degrees - other.degrees).abs();
    if (diff > 180) diff = 360 - diff;
    return diff;
  }
  
  // Métodos para debug e comparação
  
  @override
  String toString() {
    return 'Heading(${degrees.toStringAsFixed(0)}° $cardinal)';
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Heading && other.degrees == degrees;
  }
  
  @override
  int get hashCode => degrees.hashCode;
}