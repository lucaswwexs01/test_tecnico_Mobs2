import 'package:flutter/material.dart';
import '../../domain/entities/location.dart';
import '../../domain/entities/acceleration.dart';
import '../../domain/entities/heading.dart';
import '../../core/theme/colors.dart';

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
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.panelOverlayLight,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          _buildDataGrid(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.panelOverlay,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Icon(
            isCollecting ? Icons.gps_fixed : Icons.gps_off,
            color: isCollecting ? AppColors.success : AppColors.textSecondary,
            size: 24,
          ),
          const SizedBox(width: 12),
          Text(
            isCollecting ? 'Telemetria Ativa' : 'Telemetria Inativa',
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isCollecting ? AppColors.success : AppColors.textSecondary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              isCollecting ? 'ON' : 'OFF',
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataGrid() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: _buildDataItem(
              icon: Icons.speed,
              label: 'Velocidade',
              value: _formatSpeed(),
              color: AppColors.info,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildDataItem(
              icon: Icons.trending_up, // CORRIGIDO: era speedometer
              label: 'Aceleração',
              value: _formatAcceleration(),
              color: AppColors.warning,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildDataItem(
              icon: Icons.navigation,
              label: 'Direção',
              value: _formatHeading(),
              color: AppColors.success,
            ),
          ),
        ],
      ),
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
        color: AppColors.panelOverlay,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  String _formatSpeed() {
    if (currentLocation?.speedKmh == null) {
      return '0 km/h';
    }
    return '${currentLocation!.speedKmh!.toStringAsFixed(1)} km/h';
  }

  String _formatAcceleration() {
    if (currentAcceleration == null) {
      return '0.0 m/s²';
    }
    return '${currentAcceleration!.magnitude.toStringAsFixed(1)} m/s²';
  }

  String _formatHeading() {
    if (currentHeading == null) {
      return 'N/A';
    }
    return currentHeading!.cardinal;
  }
}