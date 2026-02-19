import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/repositories/app_repository.dart';
import '../../../../core/models/workfile.dart';
import '../../../../core/state/auth_state.dart';

class WorkfileTab extends ConsumerWidget {
  const WorkfileTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workfilesStream = ref.watch(appRepositoryProvider).watchWorkFiles();
    final currentUser = ref.watch(authProvider).currentUser;

    return StreamBuilder<List<WorkFile>>(
      stream: workfilesStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final workfiles = snapshot.data ?? [];

        if (workfiles.isEmpty) {
          return const Center(child: Text('No workfiles found.'));
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            int crossAxisCount = 1;
            if (width > 600) crossAxisCount = 2;
            if (width > 900) crossAxisCount = 3;

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: workfiles.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.8, // Slightly shorter than Person card
              ),
              itemBuilder: (context, index) {
                final workfile = workfiles[index];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.folder,
                              color: Colors.amber,
                              size: 32,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    workfile.areaName ?? 'Unknown Area',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    'Status: ${workfile.status}',
                                    style: TextStyle(
                                      color: workfile.status == 'Open'
                                          ? Colors.green
                                          : Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        Text('Contractor: ${workfile.contractor ?? '-'}'),
                        Text('UID: ${workfile.uid ?? '-'}'),
                        Text('Created: ${_formatDate(workfile.createAt)}'),
                        const Spacer(),
                        if (_canDelete(currentUser))
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                _confirmDelete(context, ref, workfile);
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  String _formatDate(int? millis) {
    if (millis == null) return '-';
    return DateFormat(
      'dd MMM yyyy HH:mm',
    ).format(DateTime.fromMillisecondsSinceEpoch(millis));
  }

  bool _canDelete(currentUser) {
    if (currentUser == null) return false;
    // Admin and Supervisor can delete
    return currentUser.role == 'admin' || currentUser.role == 'supervisor';
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    WorkFile workfile,
  ) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Workfile'),
        content: const Text(
          'Are you sure you want to delete this workfile? This will also delete all associated working spots.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      // Assuming uid is used as string fileID based on logic elsewhere
      final String fileID = workfile.uid.toString();
      await ref.read(appRepositoryProvider).deleteWorkFile(workfile.id, fileID);
    }
  }
}
