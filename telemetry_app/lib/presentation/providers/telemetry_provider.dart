import 'package:flutter/foundation.dart';
import '../../domain/repositories/telemetry_repository.dart';
import '../../domain/entities/location.dart';
import '../../domain/entities/acceleration.dart';
import '../../domain/entities/heading.dart';

class TelemetryProvider extends ChangeNotifier {
  
  final TelemetryRepository _repository;
  
  bool _isCollecting = false;
  bool _hasPermissions = false;
  String? _errorMessage;
  
  Location? _currentLocation;
  Acceleration? _currentAcceleration;
  Heading? _currentHeading;
  
  TelemetryProvider(this._repository);
  
  bool get isCollecting => _isCollecting;
  bool get hasPermissions => _hasPermissions;
  String? get errorMessage => _errorMessage;
  
  Location? get currentLocation => _currentLocation;
  Acceleration? get currentAcceleration => _currentAcceleration;
  Heading? get currentHeading => _currentHeading;
  
  Future<void> initialize() async {
    try {
      _errorMessage = null;
      _hasPermissions = await _repository.hasPermissions();
      
      // CORRIGIDO: Sempre obter localização inicial
      if (_hasPermissions) {
        _getInitialLocation();
      }
      
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Erro ao inicializar: ${e.toString()}';
      notifyListeners();
    }
  }
  
  void _getInitialLocation() {
    _repository.getCurrentLocation().listen(
      (location) {
        _currentLocation = location;
        notifyListeners();
      },
      onError: (error) {
        _errorMessage = 'Erro na localização: ${error.toString()}';
        notifyListeners();
      },
    );
  }
  
  Future<bool> requestPermissions() async {
    try {
      _errorMessage = null;
      _hasPermissions = await _repository.requestPermissions();
      
      // CORRIGIDO: Se obteve permissão, obter localização
      if (_hasPermissions) {
        _getInitialLocation();
      }
      
      notifyListeners();
      return _hasPermissions;
    } catch (e) {
      _errorMessage = 'Erro ao solicitar permissões: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }
  
  Future<void> startTelemetry() async {
    try {
      _errorMessage = null;
      _isCollecting = true;
      notifyListeners();
      
      // CORRIGIDO: Manter localização sempre ativa
      _repository.getCurrentLocation().listen(
        (location) {
          _currentLocation = location;
          notifyListeners();
        },
        onError: (error) {
          _errorMessage = 'Erro na localização: ${error.toString()}';
          notifyListeners();
        },
      );
      
      _repository.getAccelerationData().listen(
        (acceleration) {
          _currentAcceleration = acceleration;
          notifyListeners();
        },
        onError: (error) {
          _errorMessage = 'Erro na aceleração: ${error.toString()}';
          notifyListeners();
        },
      );
      
      _repository.getHeadingData().listen(
        (heading) {
          _currentHeading = heading;
          notifyListeners();
        },
        onError: (error) {
          _errorMessage = 'Erro na direção: ${error.toString()}';
          notifyListeners();
        },
      );
      
    } catch (e) {
      _errorMessage = 'Erro ao iniciar telemetria: ${e.toString()}';
      _isCollecting = false;
      notifyListeners();
    }
  }
  
  Future<void> stopTelemetry() async {
    try {
      _isCollecting = false;
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Erro ao parar telemetria: ${e.toString()}';
      notifyListeners();
    }
  }
  
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}