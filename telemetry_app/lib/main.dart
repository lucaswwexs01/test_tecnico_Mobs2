// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'data/datasources/gps_datasource.dart';
import 'data/datasources/sensor_datasource.dart';
import 'data/datasources/compass_datasource.dart';
import 'data/repositories/telemetry_repository_impl.dart';
import 'presentation/providers/telemetry_provider.dart';
import 'presentation/pages/telemetry_page.dart';

void main() {
  runApp(const TelemetryApp());
}

class TelemetryApp extends StatelessWidget {
  const TelemetryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // DataSources
        Provider<GpsDataSource>(
          create: (_) => GpsDataSource(),
        ),
        Provider<SensorDataSource>(
          create: (_) => SensorDataSource(),
        ),
        Provider<CompassDataSource>(
          create: (_) => CompassDataSource(),
        ),
        
        // Repository
        Provider<TelemetryRepositoryImpl>(
          create: (context) => TelemetryRepositoryImpl(
            gpsDataSource: context.read<GpsDataSource>(),
            sensorDataSource: context.read<SensorDataSource>(),
            compassDataSource: context.read<CompassDataSource>(),
          ),
        ),
        
        // Provider
        ChangeNotifierProvider<TelemetryProvider>(
          create: (context) => TelemetryProvider(
            context.read<TelemetryRepositoryImpl>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Telemetria App',
        theme: AppTheme.lightTheme,
        home: const TelemetryPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}