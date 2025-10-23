
// Constantes globais do app
class AppConstants {
  // Intervalos de atualização 
  static const int locationUpdateInterval = 1000; // 1 segundo
  static const int sensorUpdateInterval = 100;    // 100ms
  
  // Configurações de GPS
  static const double defaultAccuracy = 10.0; // metros
  static const int locationTimeout = 30; // segundos
  
  // Configurações de sensores
  static const double gravityThreshold = 9.8; // m/s²
  static const double maxAcceleration = 50.0; // m/s²
  
  // Configurações de direção
  static const double compassThreshold = 5.0; // graus
  
  // Configurações de mapa
  static const double defaultZoom = 15.0;
  static const double maxZoom = 20.0;
  static const double minZoom = 3.0;
}