import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/repositories/app_repository.dart';
import '../../core/models/workfile.dart';
import '../map/map_page.dart';
import 'widgets/workfile_card.dart';
import 'create_workfile_page.dart';
import '../../core/state/auth_state.dart';
import '../../core/widgets/global_app_bar_actions.dart';
import '../../core/utils/app_theme.dart';

class WorkfilePage extends ConsumerWidget {
  const WorkfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = AppTheme.of(context);
    final repo = ref.watch(appRepositoryProvider);
    final authState = ref.watch(authProvider);
    final currentSystemMode = authState.mode.name.toUpperCase();
    final workfilesStream = repo.watchWorkFiles();

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
              child: Icon(Icons.folder, color: theme.iconBoxIcon, size: 24),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'WORKFILES',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    fontSize: 18,
                    color: theme.appBarForeground,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'EGS WORKFILE V4.0.0',
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
      body: StreamBuilder<List<WorkFile>>(
        stream: workfilesStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(theme.loadingIndicatorColor),
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.redAccent),
              ),
            );
          }
          final allWorkfiles = snapshot.data ?? [];
          final workfiles = allWorkfiles
              .where((w) => w.equipment?.toUpperCase() == currentSystemMode)
              .toList();

          if (workfiles.isEmpty) {
            return Center(
              child: Text(
                'No workfiles found',
                style:
                    TextStyle(color: theme.textSecondary, fontSize: 16),
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 1.1,
            ),
            itemCount: workfiles.length,
            itemBuilder: (context, index) {
              final workfile = workfiles[index];
              return WorkfileCard(
                workfile: workfile,
                onTap: () {
                  ref
                      .read(authProvider.notifier)
                      .setActiveWorkfile(workfile);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const MapPage()),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.primaryButtonBackground,
        foregroundColor: theme.primaryButtonText,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreateWorkfilePage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
