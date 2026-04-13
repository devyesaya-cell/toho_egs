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
            Expanded(flex: 6, child: _buildRightPanel(syncState, theme)),
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
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  context,
                  ref,
                  'SYNC DATA',
                  Icons.sync,
                  () => ref
                      .read(syncPresenterProvider.notifier)
                      .syncDatabase(),
                  theme,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionButton(
                  context,
                  ref,
                  'GET WORK',
                  Icons.file_download,
                  () => ref
                      .read(syncPresenterProvider.notifier)
                      .getWorkfile(),
                  theme,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    WidgetRef ref,
    String label,
    IconData icon,
    VoidCallback onPressed,
    AppThemeData theme,
  ) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2ECC71),
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      ),
    );
  }

  Widget _buildRightPanel(SyncState state, AppThemeData theme) {
    // Determine connection status colors
    final isLive = state.status != SyncConnectionStatus.idle &&
        state.status != SyncConnectionStatus.error;
    final dotColor = isLive ? const Color(0xFF2ECC71) : theme.textSecondary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'ACTIVITY LOGS (${state.logs.length})',
              style: TextStyle(
                color: theme.textSecondary,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
                fontSize: 12,
              ),
            ),
            Row(
              children: [
                // LIVE STREAM indicator — semantic green when active
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'LIVE STREAM',
                  style: TextStyle(
                    color: dotColor,
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
          child: state.logs.isEmpty
              ? Center(
                  child: Text(
                    'No activity logs yet.',
                    style: TextStyle(color: theme.textSecondary, fontSize: 14),
                  ),
                )
              : ListView.separated(
                  itemCount: state.logs.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final log = state.logs[index];

                    return _buildPacketItem(
                      theme: theme,
                      title: log.isSuccess ? 'Sync Successful' : 'Sync Failed',
                      subtitle: log.isSuccess 
                          ? '${log.spotsCount} records transmitted'
                          : 'Error: ${log.errorMessage ?? "Unknown error"}',
                      icon: log.isSuccess ? Icons.cloud_done : Icons.cloud_off,
                      status: log.isSuccess ? PacketStatus.completed : PacketStatus.waiting,
                      trailingText: _formatSyncTime(log.timestamp.millisecondsSinceEpoch ~/ 1000),
                    );
                  },
                ),
        ),
      ],
    );
  }

  String _formatSyncTime(int epochSec) {
    if (epochSec == 0) return '--:--';
    final dt = DateTime.fromMillisecondsSinceEpoch(epochSec * 1000);
    return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
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
