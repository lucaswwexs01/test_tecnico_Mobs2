// lib/core/di/injector.dart

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

// Importações das camadas (vamos criar depois)
// import '../../data/repositories/telemetry_repository_impl.dart';
// import '../../domain/repositories/telemetry_repository.dart';
// import '../../domain/usecases/get_current_location.dart';
// import '../../domain/usecases/get_acceleration_data.dart';
// import '../../domain/usecases/get_heading_data.dart';
// import '../../presentation/providers/telemetry_provider.dart';

/// Classe responsável pela injeção de dependências
class Injector {
  
  /// Configura todos os providers do app
  static List<ChangeNotifierProvider> get providers {
    return [
      // Repository
      // ChangeNotifierProvider<TelemetryRepository>(
      //   create: (_) => TelemetryRepositoryImpl(),
      // ),
      
      // Use Cases
      // ChangeNotifierProvider<GetCurrentLocation>(
      //   create: (context) => GetCurrentLocation(
      //     context.read<TelemetryRepository>(),
      //   ),
      // ),
      // ChangeNotifierProvider<GetAccelerationData>(
      //   create: (context) => GetAccelerationData(
      //     context.read<TelemetryRepository>(),
      //   ),
      // ),
      // ChangeNotifierProvider<GetHeadingData>(
      //   create: (context) => GetHeadingData(
      //     context.read<TelemetryRepository>(),
      //   ),
      // ),
      
      // Providers de estado
      // ChangeNotifierProvider<TelemetryProvider>(
      //   create: (context) => TelemetryProvider(
      //     getCurrentLocation: context.read<GetCurrentLocation>(),
      //     getAccelerationData: context.read<GetAccelerationData>(),
      //     getHeadingData: context.read<GetHeadingData>(),
      //   ),
      // ),
    ];
  }
  
  /// Configura o MultiProvider com todas as dependências
  static Widget configureDependencies({
    required Widget child,
  }) {
    return MultiProvider(
      providers: providers,
      child: child,
    );
  }
}