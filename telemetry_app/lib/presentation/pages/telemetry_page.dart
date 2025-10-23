import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/telemetry_provider.dart';
import '../widgets/map_view.dart';
import '../widgets/telemetry_info_card.dart';
import '../widgets/mobs2_logo.dart';
import '../../core/theme/colors.dart';

class TelemetryPage extends StatefulWidget {
  const TelemetryPage({super.key});

  @override
  State<TelemetryPage> createState() => _TelemetryPageState();
}

class _TelemetryPageState extends State<TelemetryPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TelemetryProvider>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Consumer<TelemetryProvider>(
        builder: (context, provider, child) {
          return Stack(
            children: [
              // Mapa ocupando toda a tela
              Positioned.fill(
                child: MapView(
                  currentLocation: provider.currentLocation,
                  isLoading: provider.isCollecting,
                  errorMessage: provider.errorMessage,
                ),
              ),
              
              // Painel superior (status + logo)
              Positioned(
                top: MediaQuery.of(context).padding.top + 16,
                left: 16,
                right: 16,
                child: _buildStatusPanel(provider),
              ),
              
              // Painel inferior (dados de telemetria)
              Positioned(
                bottom: MediaQuery.of(context).padding.bottom + 16,
                left: 0,
                right: 0,
                child: TelemetryInfoCard(
                  currentLocation: provider.currentLocation,
                  currentAcceleration: provider.currentAcceleration,
                  currentHeading: provider.currentHeading,
                  isCollecting: provider.isCollecting,
                ),
              ),
              
              // Botão flutuante de controle
              Positioned(
                bottom: MediaQuery.of(context).padding.bottom + 200,
                right: 16,
                child: _buildControlButton(provider),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatusPanel(TelemetryProvider provider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.panelOverlay,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          // Logo da MOBS2
          Mobs2Logo(
            width: 80,
            height: 30,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Telemetria Inteligente',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  provider.hasPermissions 
                    ? 'GPS Ativo' 
                    : 'Aguardando permissões',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          if (provider.errorMessage != null)
            Icon(
              Icons.error_outline,
              color: AppColors.error,
              size: 20,
            ),
        ],
      ),
    );
  }

  Widget _buildControlButton(TelemetryProvider provider) {
    return FloatingActionButton(
      onPressed: () => _handleToggleTelemetry(provider),
      backgroundColor: provider.isCollecting 
        ? AppColors.error 
        : AppColors.success,
      child: Icon(
        provider.isCollecting ? Icons.stop : Icons.play_arrow,
        color: AppColors.textPrimary,
        size: 28,
      ),
    );
  }

  void _handleToggleTelemetry(TelemetryProvider provider) async {
    if (provider.isCollecting) {
      await provider.stopTelemetry();
    } else {
      if (!provider.hasPermissions) {
        await provider.requestPermissions();
      }
      await provider.startTelemetry();
    }
  }
}