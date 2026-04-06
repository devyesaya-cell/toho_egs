import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../core/widgets/global_app_bar_actions.dart';
import '../../core/utils/app_theme.dart';
import '../../core/database/voice_message_repository.dart';
import '../../core/services/voice_recognition_service.dart';
import '../../core/models/voice_message.dart';

class VoicelogsPage extends ConsumerWidget {
  const VoicelogsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = AppTheme.of(context);
    final messagesAsync = ref.watch(voiceMessageStreamProvider);

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
              child: Icon(
                Icons.warning_amber_rounded,
                color: theme.iconBoxIcon,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'VOICE LOGS / ALARM',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    fontSize: 18,
                    color: theme.appBarForeground,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'EGS ALARM V4.0.0',
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
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep_outlined),
            onPressed: () => _confirmClearLogs(context, ref, theme),
            tooltip: 'Clear Logs',
          ),
          const GlobalAppBarActions(),
          const SizedBox(width: 16),
        ],
      ),
      body: messagesAsync.when(
        data: (messages) {
          if (messages.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.speaker_notes_off_outlined,
                      size: 64, color: theme.textSecondary.withOpacity(0.3)),
                  const SizedBox(height: 16),
                  Text(
                    'Belum ada rekaman suara.',
                    style: TextStyle(color: theme.textSecondary),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final msg = messages[index];
              return _buildMessageCard(context, ref, theme, msg);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Text('Error loading messages: $err',
              style: const TextStyle(color: Colors.red)),
        ),
      ),
    );
  }

  Widget _buildMessageCard(BuildContext context, WidgetRef ref,
      AppThemeData theme, VoiceMessage msg) {
    final timeStr = DateFormat('HH:mm:ss').format(msg.timestamp);
    final dateStr = DateFormat('dd MMM yyyy').format(msg.timestamp);

    return Card(
      color: theme.cardSurface,
      margin: const EdgeInsets.only(bottom: 12.0),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: theme.cardBorderColor, width: 1),
      ),
      child: InkWell(
        onTap: () {
          ref.read(voiceRecognitionProvider.notifier).speak(msg.text);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF2ECC71).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.play_arrow_rounded,
                  color: Color(0xFF2ECC71),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          msg.sender ?? 'System',
                          style: TextStyle(
                            color: theme.appBarAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '$timeStr - $dateStr',
                          style: TextStyle(
                            color: theme.textSecondary,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      msg.text,
                      style: TextStyle(
                        color: theme.textOnSurface,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmClearLogs(
      BuildContext context, WidgetRef ref, AppThemeData theme) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: theme.dialogBackground,
        title: Text('Hapus Log?', style: TextStyle(color: theme.textOnSurface)),
        content: Text('Semua rekaman suara akan dihapus secara permanen.',
            style: TextStyle(color: theme.textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('BATAL', style: TextStyle(color: theme.textSecondary)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              ref.read(voiceMessageRepositoryProvider).clearAll();
              Navigator.of(ctx).pop();
            },
            child: const Text('HAPUS SEMUA',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
