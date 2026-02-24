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
      backgroundColor:
          Colors.transparent, // Inherit from parent or set explicitly
      appBar: AppBar(
        title: const Text(
          'WORKFILES',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder<List<WorkFile>>(
        stream: workfilesStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2ECC71)),
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
          final workfiles = snapshot.data ?? [];

          if (workfiles.isEmpty) {
            return const Center(
              child: Text(
                'No workfiles found',
                style: TextStyle(color: Color(0xFFB0BEC5), fontSize: 16),
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio:
                  1.1, // Adjusted ratio to allow more vertical space for the card details
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
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2ECC71),
        foregroundColor: const Color(0xFF0F1410),
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
