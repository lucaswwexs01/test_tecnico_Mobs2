
//excessões para o app de tele metria
class TelemetryException implements Exception {
  final String message;
  final String? code;

  const TelemetryException({required this.message, this.code});

  @override
  String toString() {
    return 'TelemetryException: $message';
  }
}

class LocationException extends TelemetryException {
  const LocationException (String message, {String? code}) : super(message: message, code: code);
}

class SensorException extends TelemetryException {
  const SensorException(String message, {String? code}) : super(message: message, code: code);
}

class PermissionException extends TelemetryException {
  const PermissionException (String message, {String? code}) : super(message: message, code: code);
}