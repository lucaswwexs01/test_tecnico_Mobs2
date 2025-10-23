import 'package:flutter/foundation.dart';
import '../../domain/repositories/telemetry_repository.dart';
import '../../domain/entities/location.dart';
import '../../domain/entities/acceleration.dart';
import '../../domain/entities/heading.dart';

/// Provider responsável por gerenciar o estado da telemetria
/// Usa ChangeNotifier para notificar a UI sobre mudanças
class TelemetryProvider extends ChangeNotifier {
  
  // Dependência (Repository)
  final TelemetryRepository _repository;
  
  // Estado da aplicação
  bool _isCollecting = false;
  bool _hasPermissions = false;
  String? _errorMessage;
  
  // Dados de telemetria
  Location? _currentLocation;
  Acceleration? _currentAcceleration;
  Heading? _currentHeading;
  
  // Construtor
  TelemetryProvider(this._repository);
  
  // Getters para o estado
  bool get isCollecting => _isCollecting;
  bool get hasPermissions => _hasPermissions;
  String? get errorMessage => _errorMessage;
  
  // Getters para os dados
  Location? get currentLocation => _currentLocation;
  Acceleration? get currentAcceleration => _currentAcceleration;
  Heading? get currentHeading => _currentHeading;
  
  /// Inicializa o Provider
  /// Verifica permissões e status inicial
  Future<void> initialize() async {
    try {
      _errorMessage = null;
      _hasPermissions = await _repository.hasPermissions();
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Erro ao inicializar: ${e.toString()}';
      notifyListeners();
    }
  }
  
  /// Solicita permissões necessárias
  Future<bool> requestPermissions() async {
    try {
      _errorMessage = null;
      _hasPermissions = await _repository.requestPermissions();
      notifyListeners();
      return _hasPermissions;
    } catch (e) {
      _errorMessage = 'Erro ao solicitar permissões: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }
  
  /// Inicia a coleta de dados de telemetria
  Future<void> startTelemetry() async {
    if (_isCollecting) return;
    
    try {
      _errorMessage = null;
      
      // Verifica permissões antes de iniciar
      if (!_hasPermissions) {
        final granted = await requestPermissions();
        if (!granted) {
          _errorMessage = 'Permissões necessárias não foram concedidas';
          notifyListeners();
          return;
        }
      }
      
      // Inicia coleta
      _isCollecting = true;
      notifyListeners();
      
      // Escuta stream de localização
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
      
      // Escuta stream de aceleração
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
      
      // Escuta stream de direção
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
  
  /// Para a coleta de dados de telemetria
  Future<void> stopTelemetry() async {
    if (!_isCollecting) return;
    
    try {
      _errorMessage = null;
      await _repository.stopTelemetry();
      _isCollecting = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Erro ao parar telemetria: ${e.toString()}';
      notifyListeners();
    }
  }
  
  /// Limpa mensagens de erro
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
  
  @override
  void dispose() {
    // Para telemetria ao destruir o Provider
    if (_isCollecting) {
      stopTelemetry();
    }
    super.dispose();
  }
}