// lib/presentation/widgets/map_view.dart

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../domain/entities/location.dart';
import '../../core/theme/colors.dart';

/// Widget responsável por exibir o mapa com a localização atual
class MapView extends StatelessWidget {
  
  final Location? currentLocation;
  final bool isLoading;
  final String? errorMessage;
  
  const MapView({
    super.key,
    required this.currentLocation,
    this.isLoading = false,
    this.errorMessage,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.accent, width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: _buildMapContent(),
      ),
    );
  }
  
  Widget _buildMapContent() {
    // Se há erro, mostra mensagem
    if (errorMessage != null) {
      return _buildErrorWidget();
    }
    
    // Se está carregando, mostra loading
    if (isLoading) {
      return _buildLoadingWidget();
    }
    
    // Se não há localização, mostra placeholder
    if (currentLocation == null) {
      return _buildPlaceholderWidget();
    }
    
    // Se há localização, mostra mapa
    return _buildMapWidget();
  }
  
  Widget _buildErrorWidget() {
    return Container(
      color: AppColors.error.withValues(alpha: 0.1),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: AppColors.error,
              size: 48,
            ),
            const SizedBox(height: 8),
            Text(
              'Erro no GPS',
              style: TextStyle(
                color: AppColors.error,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                errorMessage!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.error,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildLoadingWidget() {
    return Container(
      color: AppColors.background,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: AppColors.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'Obtendo localização...',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildPlaceholderWidget() {
    return Container(
      color: AppColors.background,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_off,
              color: AppColors.textSecondary,
              size: 48,
            ),
            const SizedBox(height: 8),
            Text(
              'Aguardando localização',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Toque em "Iniciar Coleta" para começar',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildMapWidget() {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(
          currentLocation!.latitude,
          currentLocation!.longitude,
        ),
        zoom: 15.0,
      ),
      markers: {
        Marker(
          markerId: const MarkerId('current_location'),
          position: LatLng(
            currentLocation!.latitude,
            currentLocation!.longitude,
          ),
          infoWindow: InfoWindow(
            title: 'Sua localização',
            snippet: 'Lat: ${currentLocation!.latitude.toStringAsFixed(6)}\n'
                    'Lng: ${currentLocation!.longitude.toStringAsFixed(6)}',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      },
      onMapCreated: (GoogleMapController controller) {
        // Mapa criado com sucesso
      },
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      zoomControlsEnabled: true,
      mapType: MapType.normal,
      compassEnabled: true,
      rotateGesturesEnabled: true,
      scrollGesturesEnabled: true,
      tiltGesturesEnabled: true,
      zoomGesturesEnabled: true,
    );
  }
}