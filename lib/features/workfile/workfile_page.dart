import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/repositories/app_repository.dart';
import '../../core/models/workfile.dart';
import '../map/map_page.dart';
import 'widgets/workfile_card.dart';
import 'create_workfile_page.dart';
// import '../map/map_page.dart'; // Assuming MapPage exists

class WorkfilePage extends ConsumerWidget {
  const WorkfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(appRepositoryProvider);
    final workfilesStream = repo.watchWorkFiles();

    return Scaffold(
      appBar: AppBar(title: const Text('Workfiles')),
      body: StreamBuilder<List<WorkFile>>(
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
            return const Center(child: Text('No workfiles found'));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 4 / 2.4,
            ),
            itemCount: workfiles.length,
            itemBuilder: (context, index) {
              final workfile = workfiles[index];
              return WorkfileCard(
                workfile: workfile,
                onTap: () {
                  // Navigate to MapPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const MapPage()),
                  );
                  // Placeholder for MapPage navigation
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Navigate to MapPage for ${workfile.areaName}',
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
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
