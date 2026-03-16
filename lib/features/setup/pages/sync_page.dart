import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/global_app_bar_actions.dart';
import '../presenter/sync_presenter.dart';
import '../../../core/utils/app_theme.dart';

class SyncPage extends ConsumerStatefulWidget {
  const SyncPage({super.key});

  @override
  ConsumerState<SyncPage> createState() => _SyncPageState();
}

class _SyncPageState extends ConsumerState<SyncPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(syncPresenterProvider.notifier).startSync();
    });
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final syncState = ref.watch(syncPresenterProvider);

    return Scaffold(
      backgroundColor: theme.pageBackground,
      appBar: AppBar(
        backgroundColor: theme.appBarBackground,
        foregroundColor: theme.appBarForeground,
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: theme.iconBoxBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.sync, color: theme.iconBoxIcon, size: 24),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SYNCHRONIZE',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    fontSize: 18,
                    color: theme.appBarForeground,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'EGS SYNCHRONIZE V4.0.0',
                  style: TextStyle(
                    color: theme.appBarAccent,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: const [GlobalAppBarActions(), SizedBox(width: 16)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(flex: 4, child: _buildLeftPanel(syncState, theme)),
            const SizedBox(width: 24),
            Expanded(flex: 6, child: _buildRightPanel(theme)),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftPanel(SyncState state, AppThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.cardSurface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.cardBorderColor, width: 1),
      ),
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 160,
            width: 160,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: state.progress,
                  strokeWidth: 12,
                  backgroundColor: theme.cardBorderColor,
                  valueColor: AlwaysStoppedAnimation<Color>(theme.appBarAccent),
                  strokeCap: StrokeCap.round,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${(state.progress * 100).toInt()}%',
                      style: TextStyle(
                        color: theme.textOnSurface,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'SYNCED',
                      style: TextStyle(
                        color: theme.textSecondary,
                        fontSize: 12,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
          Text(
            state.statusText,
            style: TextStyle(
              color: theme.textOnSurface,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'Automatic transmission active via COM\nconnection. Do not disconnect.',
            style: TextStyle(
                color: theme.textSecondary, fontSize: 13, height: 1.5),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRightPanel(AppThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'DATA PACKETS (6)',
              style: TextStyle(
                color: theme.textSecondary,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
                fontSize: 12,
              ),
            ),
            Row(
              children: [
                // LIVE STREAM indicator — semantic green, always
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2ECC71),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'LIVE STREAM',
                  style: TextStyle(
                    color: Color(0xFF2ECC71),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView(
            children: [
              _buildPacketItem(
                theme: theme,
                title: 'Telemetry_Log_01.dat',
                subtitle: '1.2 MB • Completed 10:42 AM',
                icon: Icons.insert_drive_file_outlined,
                status: PacketStatus.completed,
              ),
              const SizedBox(height: 12),
              _buildPacketItem(
                theme: theme,
                title: 'Guidance_Path_A12.gps',
                subtitle: '840 KB • Completed 10:45 AM',
                icon: Icons.location_on_outlined,
                status: PacketStatus.completed,
              ),
              const SizedBox(height: 12),
              _buildPacketItem(
                theme: theme,
                title: 'Forest_Scan_V2.raw',
                subtitle: 'Uploading (1.4MB/2.1MB)',
                icon: Icons.sync,
                status: PacketStatus.uploading,
                progress: 1.4 / 2.1,
              ),
              const SizedBox(height: 12),
              _buildPacketItem(
                theme: theme,
                title: 'Operator_Notes_B4.txt',
                subtitle: 'Waiting in queue',
                icon: Icons.more_horiz,
                status: PacketStatus.waiting,
                trailingText: '12 KB',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPacketItem({
    required AppThemeData theme,
    required String title,
    required String subtitle,
    required IconData icon,
    required PacketStatus status,
    double? progress,
    String? trailingText,
  }) {
    final isUploading = status == PacketStatus.uploading;
    final isWaiting = status == PacketStatus.waiting;
    final isCompleted = status == PacketStatus.completed;

    // Status-specific colors are semantic
    Color borderColor = Colors.transparent;
    Color iconColor = theme.textSecondary;
    Color titleColor = theme.textOnSurface;
    Color subtitleColor = theme.textSecondary;

    if (isUploading) {
      borderColor = theme.appBarAccent.withValues(alpha: 0.5);
      iconColor = theme.appBarAccent;
      titleColor = theme.textOnSurface;
      subtitleColor = theme.appBarAccent;
    } else if (isWaiting) {
      borderColor = theme.dividerColor;
      titleColor = theme.textSecondary;
      subtitleColor = theme.textSecondary.withValues(alpha: 0.7);
      iconColor = theme.textSecondary.withValues(alpha: 0.5);
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isWaiting
              ? theme.dividerColor
              : (isUploading ? borderColor : theme.cardBorderColor),
          width: isUploading ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isWaiting ? Colors.transparent : theme.iconBoxBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        color: titleColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: TextStyle(color: subtitleColor, fontSize: 12)),
              ],
            ),
          ),
          if (isCompleted)
            Icon(Icons.check_circle_outline,
                color: theme.appBarAccent, size: 24) // semantic accent
          else if (isUploading && progress != null)
            SizedBox(
              width: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: theme.cardBorderColor,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(theme.appBarAccent),
                  minHeight: 6,
                ),
              ),
            )
          else if (trailingText != null)
            Text(
              trailingText,
              style: TextStyle(
                color: theme.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
        ],
      ),
    );
  }
}

enum PacketStatus { completed, uploading, waiting }
