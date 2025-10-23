import 'package:geolocator/geolocator.dart';
import '../models/location_model.dart';
import '../../core/errors/exceptions.dart';
import '../../core/utils/constants.dart';

/// DataSource responsável por coletar dados de GPS
/// Usa o pacote geolocator para acessar localização em tempo real
class GpsDataSource {
  
  /// Obtém stream de localização em tempo real
  /// Retorna um `Stream<LocationModel>` que emite atualizações contínuas
  Stream<LocationModel> getCurrentLocation() {
    try {
      // Configurações para o GPS
      const LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 1, // Atualiza a cada 1 metro
      );
      
      // Retorna stream de posições GPS
      return Geolocator.getPositionStream(
        locationSettings: locationSettings,
      ).map((Position position) {
        // Converte Position (geolocator) para LocationModel
        return LocationModel.fromGpsData(
          latitude: position.latitude,
          longitude: position.longitude,
          speed: position.speed, // em m/s
          accuracy: position.accuracy, // em metros
        );
      });
      
    } catch (e) {
      // Se der erro, lança exceção personalizada
      throw LocationException(
        'Erro ao obter localização: ${e.toString()}',
        code: 'GPS_ERROR',
      );
    }
  }
  
  /// Verifica se o app tem permissão de localização
  Future<bool> hasLocationPermission() async {
    try {
      final permission = await Geolocator.checkPermission();
      
      // Retorna true se tem permissão
      return permission == LocationPermission.always ||
             permission == LocationPermission.whileInUse;
             
    } catch (e) {
      throw PermissionException(
        'Erro ao verificar permissão de localização: ${e.toString()}',
        code: 'PERMISSION_CHECK_ERROR',
      );
    }
  }
  
  /// Solicita permissão de localização ao usuário
  Future<bool> requestLocationPermission() async {
    try {
      // Verifica se já tem permissão
      final hasPermission = await hasLocationPermission();
      if (hasPermission) return true;
      
      // Solicita permissão
      final permission = await Geolocator.requestPermission();
      
      // Retorna true se foi concedida
      return permission == LocationPermission.always ||
             permission == LocationPermission.whileInUse;
             
    } catch (e) {
      throw PermissionException(
        'Erro ao solicitar permissão de localização: ${e.toString()}',
        code: 'PERMISSION_REQUEST_ERROR',
      );
    }
  }
  
  /// Verifica se o GPS está habilitado
  Future<bool> isGpsEnabled() async {
    try {
      return await Geolocator.isLocationServiceEnabled();
    } catch (e) {
      throw LocationException(
        'Erro ao verificar status do GPS: ${e.toString()}',
        code: 'GPS_STATUS_ERROR',
      );
    }
  }
  
  /// Obtém localização atual (uma única vez)
  Future<LocationModel> getCurrentPosition() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: AppConstants.locationTimeout),
      );
      
      return LocationModel.fromGpsData(
        latitude: position.latitude,
        longitude: position.longitude,
        speed: position.speed,
        accuracy: position.accuracy,
      );
      
    } catch (e) {
      throw LocationException(
        'Erro ao obter posição atual: ${e.toString()}',
        code: 'CURRENT_POSITION_ERROR',
      );
    }
  }
}