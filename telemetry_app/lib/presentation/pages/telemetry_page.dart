// lib/presentation/pages/telemetry_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/telemetry_provider.dart';
import '../widgets/map_view.dart';
import '../widgets/telemetry_info_card.dart';
import '../../core/theme/colors.dart';

/// Tela principal do app de telemetria
/// Exibe mapa, dados e controles de coleta
class TelemetryPage extends StatefulWidget {
  const TelemetryPage({super.key});

  @override
  State<TelemetryPage> createState() => _TelemetryPageState();
}

class _TelemetryPageState extends State<TelemetryPage> {
  
  @override
  void initState() {
    super.initState();
    // Inicializa o Provider quando a tela é criada
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TelemetryProvider>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('Telemetria'),
      centerTitle: true,
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
    );
  }

  Widget _buildBody() {
    return Consumer<TelemetryProvider>(
      builder: (context, provider, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Mapa
              MapView(
                currentLocation: provider.currentLocation,
                isLoading: provider.isCollecting && provider.currentLocation == null,
                errorMessage: provider.errorMessage,
              ),
              
              const SizedBox(height: 16),
              
              // Card com dados de telemetria
              TelemetryInfoCard(
                currentLocation: provider.currentLocation,
                currentAcceleration: provider.currentAcceleration,
                currentHeading: provider.currentHeading,
                isCollecting: provider.isCollecting,
              ),
              
              const SizedBox(height: 16),
              
              // Status e controles
              _buildStatusSection(provider),
              
              const SizedBox(height: 16),
              
              // Informações adicionais
              _buildInfoSection(provider),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatusSection(TelemetryProvider provider) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Status da Coleta',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            // Status das permissões
            Row(
              children: [
                Icon(
                  provider.hasPermissions ? Icons.check_circle : Icons.cancel,
                  color: provider.hasPermissions ? AppColors.success : AppColors.error,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  provider.hasPermissions ? 'Permissões concedidas' : 'Permissões necessárias',
                  style: TextStyle(
                    color: provider.hasPermissions ? AppColors.success : AppColors.error,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            
            // Status da coleta
            Row(
              children: [
                Icon(
                  provider.isCollecting ? Icons.play_circle : Icons.pause_circle,
                  color: provider.isCollecting ? AppColors.success : AppColors.warning,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  provider.isCollecting ? 'Coletando dados' : 'Coleta parada',
                  style: TextStyle(
                    color: provider.isCollecting ? AppColors.success : AppColors.warning,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            
            // Mensagem de erro
            if (provider.errorMessage != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: AppColors.error,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        provider.errorMessage!,
                        style: TextStyle(
                          color: AppColors.error,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => provider.clearError(),
                      icon: Icon(
                        Icons.close,
                        color: AppColors.error,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(TelemetryProvider provider) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Informações',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            Text(
              '• Toque no botão flutuante para iniciar/parar a coleta\n'
              '• O app precisa de permissão de localização\n'
              '• Os dados são atualizados em tempo real\n'
              '• Para melhor precisão, mantenha o GPS ligado',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return Consumer<TelemetryProvider>(
      builder: (context, provider, child) {
        return FloatingActionButton.extended(
          onPressed: () => _handleToggleTelemetry(provider),
          backgroundColor: provider.isCollecting ? AppColors.error : AppColors.primary,
          foregroundColor: AppColors.textPrimary,
          icon: Icon(
            provider.isCollecting ? Icons.stop : Icons.play_arrow,
          ),
          label: Text(
            provider.isCollecting ? 'Parar Coleta' : 'Iniciar Coleta',
          ),
        );
      },
    );
  }

  void _handleToggleTelemetry(TelemetryProvider provider) {
    if (provider.isCollecting) {
      provider.stopTelemetry();
    } else {
      provider.startTelemetry();
    }
  }
}