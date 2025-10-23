import 'package:sensors_plus/sensors_plus.dart';
import 'dart:math';
import '../models/heading_model.dart';
import '../../core/errors/exceptions.dart';

/// DataSource responsável por coletar dados de direção/bússola
/// Usa o magnetômetro para calcular heading (direção) em graus
class CompassDataSource {
  
  /// Obtém stream de dados de direção em tempo real
  /// Retorna um `Stream<HeadingModel>` que emite atualizações contínuas
  Stream<HeadingModel> getHeadingData() {
    try {
      // Retorna stream do magnetômetro
      return magnetometerEventStream().map((MagnetometerEvent event) {
        // Calcula heading a partir dos dados magnéticos
        final heading = _calculateHeading(event.x, event.y);
        
        // Converte MagnetometerEvent para HeadingModel
        return HeadingModel.fromCompassData(
          degrees: heading,
        );
      });
      
    } catch (e) {
      // Se der erro, lança exceção personalizada
      throw SensorException(
        'Erro ao obter dados de direção: ${e.toString()}',
        code: 'COMPASS_ERROR',
      );
    }
  }
  
  /// Calcula heading (direção) a partir dos dados do magnetômetro
  /// Usa atan2 para calcular o ângulo em relação ao norte magnético
  double _calculateHeading(double x, double y) {
    // Calcula o ângulo em radianos usando atan2
    double headingRadians = atan2(y, x);
    
    // Converte para graus
    double headingDegrees = headingRadians * (180 / pi);
    
    // Normaliza para 0-360 graus
    // Adiciona 360 e usa módulo para garantir valores positivos
    double normalizedHeading = (headingDegrees + 360) % 360;
    
    return normalizedHeading;
  }
  
  /// Verifica se o magnetômetro está disponível no dispositivo
  Future<bool> isMagnetometerAvailable() async {
    try {
      // Tenta obter um evento do magnetômetro para testar
      final subscription = magnetometerEventStream().listen((event) {
        // Se conseguiu obter dados, o magnetômetro está funcionando
      });
      
      // Cancela a subscription imediatamente (só era para testar)
      await subscription.cancel();
      
      return true;
      
    } catch (e) {
      // Se deu erro, o magnetômetro não está disponível
      return false;
    }
  }
  
  /// Obtém direção atual uma única vez
  Future<HeadingModel> getCurrentHeading() async {
    try {
      // Escuta apenas o primeiro evento do stream
      final event = await magnetometerEventStream().first;
      
      // Calcula heading
      final heading = _calculateHeading(event.x, event.y);
      
      return HeadingModel.fromCompassData(
        degrees: heading,
      );
      
    } catch (e) {
      throw SensorException(
        'Erro ao obter direção atual: ${e.toString()}',
        code: 'CURRENT_HEADING_ERROR',
      );
    }
  }
  
  /// Filtra dados de direção estáveis
  /// Remove flutuações pequenas e mantém apenas mudanças significativas
  Stream<HeadingModel> getStableHeading({
    double threshold = 5.0, // graus
  }) {
    try {
      double? lastHeading;
      
      return magnetometerEventStream()
          .map((MagnetometerEvent event) {
            final heading = _calculateHeading(event.x, event.y);
            return HeadingModel.fromCompassData(degrees: heading);
          })
          .where((HeadingModel model) {
            // Se é o primeiro valor, sempre inclui
            if (lastHeading == null) {
              lastHeading = model.degrees;
              return true;
            }
            
            // Calcula diferença com o último valor
            final difference = (model.degrees - lastHeading!).abs();
            
            // Se a diferença é significativa, atualiza e inclui
            if (difference >= threshold) {
              lastHeading = model.degrees;
              return true;
            }
            
            // Se não é significativa, descarta
            return false;
          });
          
    } catch (e) {
      throw SensorException(
        'Erro ao filtrar direção estável: ${e.toString()}',
        code: 'STABLE_HEADING_ERROR',
      );
    }
  }
  
  /// Obtém dados brutos do magnetômetro
  Stream<MagnetometerEvent> getRawMagnetometerData() {
    try {
      return magnetometerEventStream();
    } catch (e) {
      throw SensorException(
        'Erro ao obter dados brutos do magnetômetro: ${e.toString()}',
        code: 'RAW_MAGNETOMETER_ERROR',
      );
    }
  }
  
  /// Calcula intensidade do campo magnético
  Stream<double> getMagneticFieldStrength() {
    try {
      return magnetometerEventStream().map((MagnetometerEvent event) {
        // Calcula magnitude do vetor magnético
        return sqrt(event.x * event.x + event.y * event.y + event.z * event.z);
      });
    } catch (e) {
      throw SensorException(
        'Erro ao calcular intensidade magnética: ${e.toString()}',
        code: 'MAGNETIC_STRENGTH_ERROR',
      );
    }
  }
} 