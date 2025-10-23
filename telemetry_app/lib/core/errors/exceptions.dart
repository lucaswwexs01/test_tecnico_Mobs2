
// Exceções customizadas 
class TelemetryException implements Exception {
  final String message;
  final String? code;
  
  const TelemetryException(this.message, {this.code});
  
  @override
  String toString() => 'TelemetryException: $message';
}

// Exceção específica para erros de localização
class LocationException extends TelemetryException {
  const LocationException(super.message, {super.code});
}

// Exceção específica para erros de sensores
class SensorException extends TelemetryException {
  const SensorException(super.message, {super.code});
}

// Exceção específica para erros de permissões
class PermissionException extends TelemetryException {
  const PermissionException(super.message, {super.code});
}