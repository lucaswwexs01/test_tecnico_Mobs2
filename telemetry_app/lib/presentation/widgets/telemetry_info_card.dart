// lib/presentation/widgets/telemetry_info_card.dart

import 'package:flutter/material.dart';
import '../../domain/entities/location.dart';
import '../../domain/entities/acceleration.dart';
import '../../domain/entities/heading.dart';
import '../../core/theme/colors.dart';

/// Widget responsável por exibir os dados de telemetria
class TelemetryInfoCard extends StatelessWidget {
  
  final Location? currentLocation;
  final Acceleration? currentAcceleration;
  final Heading? currentHeading;
  final bool isCollecting;
  
  const TelemetryInfoCard({
    super.key,
    required this.currentLocation,
    required this.currentAcceleration,
    required this.currentHeading,
    required this.isCollecting,
  });
  
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary.withValues(alpha: 0.1),
              AppColors.secondary.withValues(alpha: 0.1),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            _buildDataGrid(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildHeader() {
    return Row(
      children: [
        Icon(
          Icons.analytics,
          color: AppColors.primary,
          size: 24,
        ),
        const SizedBox(width: 8),
        Text(
          'Dados de Telemetria',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: isCollecting ? AppColors.success : AppColors.warning,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            isCollecting ? 'COLETANDO' : 'PARADO',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildDataGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildDataItem(
              icon: Icons.location_on,
              label: 'Localização',
              value: _formatLocation(),
              color: AppColors.primary,
            )),
            const SizedBox(width: 16),
            Expanded(child: _buildDataItem(
              icon: Icons.speed,
              label: 'Velocidade',
              value: _formatSpeed(),
              color: AppColors.accent,
            )),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildDataItem(
              icon: Icons.trending_up,
              label: 'Aceleração',
              value: _formatAcceleration(),
              color: AppColors.success,
            )),
            const SizedBox(width: 16),
            Expanded(child: _buildDataItem(
              icon: Icons.explore,
              label: 'Direção',
              value: _formatHeading(),
              color: AppColors.warning,
            )),
          ],
        ),
      ],
    );
  }
  
  Widget _buildDataItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 16),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
  
  String _formatLocation() {
    if (currentLocation == null) return 'N/A';
    return '${currentLocation!.latitude.toStringAsFixed(6)}\n'
           '${currentLocation!.longitude.toStringAsFixed(6)}';
  }
  
  String _formatSpeed() {
    if (currentLocation?.speedKmh == null) return '0 km/h';
    return '${currentLocation!.speedKmh!.toStringAsFixed(1)} km/h';
  }
  
  String _formatAcceleration() {
    if (currentAcceleration == null) return '0 m/s²';
    return '${currentAcceleration!.magnitude.toStringAsFixed(2)} m/s²';
  }
  
  String _formatHeading() {
    if (currentHeading == null) return 'N/A';
    return '${currentHeading!.degrees.toStringAsFixed(0)}°\n'
           '${currentHeading!.cardinal}';
  }
}