import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/person.dart';
import '../../../../core/repositories/app_repository.dart';
import '../../../../core/models/workfile.dart';
import '../../../../core/state/auth_state.dart';
import 'workfile_card_widget.dart';

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
          return const Center(
            child: Text(
              'No workfiles found.',
              style: TextStyle(color: Colors.white54),
            ),
          );
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            // Responsive Columns
            int crossAxisCount = 2;
            if (width > 700) crossAxisCount = 3;
            if (width > 1000) crossAxisCount = 4;
            if (width > 1400) crossAxisCount = 5;

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: workfiles.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85, // Adjust for card content
              ),
              itemBuilder: (context, index) {
                final workfile = workfiles[index];
                return WorkfileCardWidget(
                  workfile: workfile,
                  showDelete: _canDelete(currentUser),
                  onDelete: () {
                    _confirmDelete(context, ref, workfile);
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  bool _canDelete(Person? currentUser) {
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
        backgroundColor: const Color(0xFF0F1410),
        title: const Text(
          'Delete Workfile',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Are you sure you want to delete this workfile? This will also delete all associated working spots.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white54),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFEF4444)),
            child: const Text('Delete'),
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
