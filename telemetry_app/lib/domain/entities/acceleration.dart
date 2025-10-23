
import 'dart:math';

/// Entidade que representa dados de aceleração
class Acceleration {
  final double x; // Aceleração no eixo X (esquerda/direita)
  final double y; // Aceleração no eixo Y (frente/trás)
  final double z; // Aceleração no eixo Z (cima/baixo)
  final DateTime timestamp; // Quando foi coletado
  
  // Construtor 
  const Acceleration({
    required this.x,
    required this.y,
    required this.z,
    required this.timestamp,
  });
  
  // Métodos (o que podemos fazer com uma aceleração)
  
  /// Calcula a magnitude da aceleração
  /// É como calcular o "tamanho" do vetor de aceleração
  /// Fórmula: √(x² + y² + z²)
  double get magnitude {
    return sqrt(x * x + y * y + z * z);
  }
  
  /// Calcula a aceleração sem a gravidade
  /// A gravidade sempre puxa para baixo (~9.8 m/s²)
  /// Então subtraímos para ter a aceleração "real"
  double get magnitudeWithoutGravity {
    return (magnitude - 9.8).abs();
  }
  
  /// Verifica se a aceleração é significativa
  /// Se for maior que o threshold, significa que o celular está se movendo
  bool isSignificant({double threshold = 1.0}) {
    return magnitudeWithoutGravity > threshold;
  }
  
  /// Retorna a direção da aceleração em graus
  /// Usa trigonometria para calcular o ângulo
  double get direction {
    return atan2(y, x) * (180 / pi);
  }
  
  // Métodos para debug e comparação
  
  @override
  String toString() {
    return 'Acceleration(x: ${x.toStringAsFixed(2)}, y: ${y.toStringAsFixed(2)}, z: ${z.toStringAsFixed(2)}, magnitude: ${magnitude.toStringAsFixed(2)} m/s²)';
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Acceleration &&
           other.x == x &&
           other.y == y &&
           other.z == z;
  }
  
  @override
  int get hashCode {
    return x.hashCode ^ y.hashCode ^ z.hashCode;
  }
}