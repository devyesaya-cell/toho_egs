import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/global_app_bar_actions.dart';
import '../presenter/sync_presenter.dart';

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
      ref.read(syncPresenterProvider.notifier).startDiscovery();
    });
  }

  @override
  void deactivate() {
    ref.read(syncPresenterProvider.notifier).stopSync();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final syncState = ref.watch(syncPresenterProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0F1410),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F1410),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            // Green Icon Box
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF1E3A2A),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.sync, color: Color(0xFF2ECC71), size: 24),
            ),
            const SizedBox(width: 16),
            // Titles
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SYNCHRONIZE',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'EGS SYNCHRONIZE V4.0.0',
                  style: TextStyle(
                    color: Color(0xFF2ECC71), // Primary Green
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
            // Left Panel (40%)
            Expanded(flex: 4, child: _buildLeftPanel(syncState)),
            const SizedBox(width: 24),
            // Right Panel (60%)
            Expanded(flex: 6, child: _buildRightPanel()),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftPanel(SyncState state) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF162118),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF1E3A2A), width: 1),
      ),
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Circular Progress
          SizedBox(
            height: 160,
            width: 160,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: state.progress,
                  strokeWidth: 12,
                  backgroundColor: const Color(0xFF1E3A2A),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFF2ECC71),
                  ),
                  strokeCap: StrokeCap.round,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${(state.progress * 100).toInt()}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'SYNCED',
                      style: TextStyle(
                        color: Colors.white54,
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
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          const Text(
            'Automatic transmission active via COM\nconnection. Do not disconnect.',
            style: TextStyle(color: Colors.white54, fontSize: 13, height: 1.5),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRightPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'DATA PACKETS (6)',
              style: TextStyle(
                color: Colors.white54,
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
        // List
        Expanded(
          child: ListView(
            children: [
              _buildPacketItem(
                title: 'Telemetry_Log_01.dat',
                subtitle: '1.2 MB • Completed 10:42 AM',
                icon: Icons.insert_drive_file_outlined,
                status: PacketStatus.completed,
              ),
              const SizedBox(height: 12),
              _buildPacketItem(
                title: 'Guidance_Path_A12.gps',
                subtitle: '840 KB • Completed 10:45 AM',
                icon: Icons.location_on_outlined,
                status: PacketStatus.completed,
              ),
              const SizedBox(height: 12),
              _buildPacketItem(
                title: 'Forest_Scan_V2.raw',
                subtitle: 'Uploading (1.4MB/2.1MB)',
                icon: Icons.sync,
                status: PacketStatus.uploading,
                progress: 1.4 / 2.1,
              ),
              const SizedBox(height: 12),
              _buildPacketItem(
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

    Color borderColor = Colors.transparent;
    Color iconColor = Colors.white54;
    Color titleColor = Colors.white;
    Color subtitleColor = Colors.white54;

    if (isUploading) {
      borderColor = const Color(
        0xFF2ECC71,
      ).withAlpha(128); // Green border for active
      iconColor = const Color(0xFF2ECC71);
      titleColor = Colors.white;
      subtitleColor = const Color(0xFF2ECC71);
    } else if (isWaiting) {
      borderColor = Colors.white10;
      titleColor = Colors.white38;
      subtitleColor = Colors.white30;
      iconColor = Colors.white24;
    } else if (isCompleted) {
      iconColor = Colors.white54;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF162118),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isWaiting
              ? Colors.white10
              : (isUploading ? borderColor : const Color(0xFF1E3A2A)),
          width: isUploading ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isWaiting ? Colors.transparent : const Color(0xFF1E3A2A),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          // Texts
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: titleColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(color: subtitleColor, fontSize: 12),
                ),
              ],
            ),
          ),
          // Trailing
          if (isCompleted)
            const Icon(
              Icons.check_circle_outline,
              color: Color(0xFF2ECC71),
              size: 24,
            )
          else if (isUploading && progress != null)
            SizedBox(
              width: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: const Color(0xFF1E3A2A),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFF2ECC71),
                  ),
                  minHeight: 6,
                ),
              ),
            )
          else if (trailingText != null)
            Text(
              trailingText,
              style: const TextStyle(
                color: Colors.white38,
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
