import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/global_app_bar_actions.dart';
import '../presenter/sync_presenter.dart';
import '../../../core/utils/app_theme.dart';
import '../../../core/models/sync_data_result.dart';
import '../../../core/state/auth_state.dart';
import '../../../core/repositories/app_repository.dart';

final syncDataStreamProvider = StreamProvider.autoDispose<List<SyncDataResult>>((ref) {
  final auth = ref.watch(authProvider);
  final driverId = auth.currentUser?.uid ?? '';
  if (driverId.isEmpty) return Stream.value([]);
  return ref.watch(appRepositoryProvider).watchSyncDataResults(driverId);
});

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
    final isGetWorkCooldown = state.isGetWorkfileCooldown;

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
                  value: state.uploadProgress,
                  strokeWidth: 12,
                  backgroundColor: theme.cardBorderColor,
                  valueColor: AlwaysStoppedAnimation<Color>(theme.appBarAccent),
                  strokeCap: StrokeCap.round,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${(state.uploadProgress * 100).toInt()}%',
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
                  isDisabled: false,
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
                  isDisabled: isGetWorkCooldown,
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
    AppThemeData theme, {
    bool isDisabled = false,
  }) {
    return ElevatedButton.icon(
      onPressed: isDisabled ? null : onPressed,
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
        backgroundColor: isDisabled ? theme.cardBorderColor : const Color(0xFF2ECC71),
        foregroundColor: isDisabled ? theme.textSecondary : Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      ),
    );
  }

  Widget _buildRightPanel(SyncState state, AppThemeData theme) {
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
              'PAYLOAD HISTORY',
              style: TextStyle(
                color: theme.textSecondary,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
                fontSize: 12,
              ),
            ),
            Row(
              children: [
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
                  isLive ? 'CONNECTED TO HOST' : 'DISCONNECTED',
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
          child: ref.watch(syncDataStreamProvider).when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(
                child: Text('Error: $err', style: const TextStyle(color: Colors.red))),
            data: (results) {
              if (results.isEmpty) {
                return Center(
                  child: Text(
                    'No payloads generated yet.',
                    style: TextStyle(color: theme.textSecondary, fontSize: 14),
                  ),
                );
              }
              return ListView.separated(
                itemCount: results.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return _buildSyncDataCard(results[index], state, theme);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSyncDataCard(SyncDataResult data, SyncState state, AppThemeData theme) {
    final isSent = data.status == 'sent';
    final isUploading = state.activeUploadId == data.id;
    final progress = isUploading ? state.uploadProgress : null;

    final shiftTitle = data.shift?.toUpperCase() ?? '';
    final title = '$shiftTitle ${_formatDateOnly(data.shiftTime)}';
    final sizeStr = _formatBytes(29 + ((data.totalSpot ?? 0) * 18));
    final syncStr = (data.syncTime == null || data.syncTime == 0) ? 'Not sent' : _formatTimestamp(data.syncTime);
    
    final bgColor = theme.cardSurface;
    final borderColor = isSent ? const Color(0xFF2ECC71).withValues(alpha: 0.5) : theme.cardBorderColor;
    final pillColor = isSent ? const Color(0xFF2ECC71).withValues(alpha: 0.1) : Colors.orange.withValues(alpha: 0.1);
    final pillTextColor = isSent ? const Color(0xFF2ECC71) : Colors.orange;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isUploading ? theme.appBarAccent : borderColor,
          width: isUploading ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(isSent ? Icons.cloud_done : Icons.cloud_upload, color: pillTextColor, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(title, style: TextStyle(color: theme.textOnSurface, fontWeight: FontWeight.bold, fontSize: 15)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: pillColor, borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: pillTextColor.withValues(alpha: 0.3)),
                ),
                child: Text(
                  isSent ? 'SENT' : 'PENDING',
                  style: TextStyle(color: pillTextColor, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Divider(color: theme.dividerColor, height: 1),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 14, color: theme.textSecondary),
              const SizedBox(width: 4),
              Text('Sync: $syncStr', style: TextStyle(color: theme.textSecondary, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.code, size: 14, color: theme.textSecondary),
              const SizedBox(width: 4),
              Text('Records: ${data.totalSpot} spots', style: TextStyle(color: theme.textSecondary, fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(width: 16),
              Icon(Icons.list, size: 14, color: theme.textSecondary),
              const SizedBox(width: 4),
              Text('Ukuran: $sizeStr', style: TextStyle(color: theme.textSecondary, fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
          
          const SizedBox(height: 16),
          
          if (isUploading && progress != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Mengirim...', style: TextStyle(color: theme.appBarAccent, fontSize: 12, fontWeight: FontWeight.bold)),
                Text('${(progress * 100).toInt()}%', style: TextStyle(color: theme.textSecondary, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: theme.cardBorderColor,
              valueColor: AlwaysStoppedAnimation<Color>(theme.appBarAccent),
              minHeight: 6,
            ),
          ] else ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () {
                    ref.read(appRepositoryProvider).deleteSyncDataResult(data.id);
                  },
                  icon: const Icon(Icons.delete_outline, size: 16, color: Colors.redAccent),
                  label: const Text('Hapus', style: TextStyle(color: Colors.redAccent, fontSize: 13)),
                ),
                if (!isSent) ...[
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      ref.read(syncPresenterProvider.notifier).sendPayloadForShift(data);
                    },
                    icon: const Icon(Icons.send, size: 16),
                    label: const Text('Kirim ke Server'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.appBarAccent,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ],
              ],
            )
          ]
        ],
      ),
    );
  }

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    final kb = bytes / 1024;
    if (kb < 1024) return '${kb.toStringAsFixed(1)} KB';
    return '${(kb / 1024).toStringAsFixed(1)} MB';
  }

  String _formatTimestamp(int? epochSec) {
    if (epochSec == null || epochSec == 0) return '--:--';
    final dt = DateTime.fromMillisecondsSinceEpoch(epochSec * 1000);
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${dt.day} ${months[dt.month - 1]} ${dt.year} • ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  String _formatDateOnly(int? epochSec) {
    if (epochSec == null || epochSec == 0) return '';
    final dt = DateTime.fromMillisecondsSinceEpoch(epochSec * 1000);
    final months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    return '${dt.day} ${months[dt.month - 1]} ${dt.year}';
  }
}

enum PacketStatus { completed, uploading, waiting }
