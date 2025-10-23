import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../domain/entities/location.dart';
import '../../core/theme/colors.dart';

class MapView extends StatelessWidget {
  final Location? currentLocation;
  final bool isLoading;
  final String? errorMessage;
  final Function(LatLng)? onMapTap;
  final Function(CameraPosition)? onCameraMove;

  const MapView({
    super.key,
    required this.currentLocation,
    this.isLoading = false,
    this.errorMessage,
    this.onMapTap,
    this.onCameraMove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(0),
        child: _buildMapContent(context),
      ),
    );
  }

  Widget _buildMapContent(BuildContext context) {
    if (errorMessage != null) {
      return _buildErrorWidget(context);
    }

    if (isLoading) {
      return _buildLoadingWidget(context);
    }

    if (currentLocation == null) {
      return _buildPlaceholderWidget(context);
    }

    return _buildMapWidget();
  }

  Widget _buildErrorWidget(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: AppColors.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Erro ao carregar mapa',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              errorMessage!,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingWidget(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
            const SizedBox(height: 16),
            Text(
              'Carregando mapa...',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.background,
            AppColors.secondary,
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.map_outlined,
              size: 80,
              color: AppColors.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'Mapa não disponível',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Toque em "Iniciar Coleta" para ativar o GPS',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
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
      onMapCreated: (GoogleMapController controller) {
        // Controller configurado
      },
      onTap: onMapTap,
      onCameraMove: onCameraMove,
      markers: {
        Marker(
          markerId: const MarkerId('current_location'),
          position: LatLng(
            currentLocation!.latitude,
            currentLocation!.longitude,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueBlue,
          ),
          infoWindow: InfoWindow(
            title: 'Localização Atual',
            snippet: 'Lat: ${currentLocation!.latitude.toStringAsFixed(6)}\n'
                'Lng: ${currentLocation!.longitude.toStringAsFixed(6)}',
          ),
        ),
      },
      mapType: MapType.normal,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      mapToolbarEnabled: false,
      compassEnabled: true,
      rotateGesturesEnabled: true,
      scrollGesturesEnabled: true,
      tiltGesturesEnabled: true,
      zoomGesturesEnabled: true,
    );
  }
}