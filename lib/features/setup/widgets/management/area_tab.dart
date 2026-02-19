import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/repositories/app_repository.dart';
import '../../../../core/models/area.dart';

class AreaTab extends ConsumerWidget {
  const AreaTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final areasStream = ref.watch(appRepositoryProvider).watchAreas();

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showEditDialog(context, ref, null);
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<Area>>(
        stream: areasStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final areas = snapshot.data ?? [];

          if (areas.isEmpty) {
            return const Center(child: Text('No areas found.'));
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              int crossAxisCount = 1;
              if (width > 600) crossAxisCount = 2;
              if (width > 900) crossAxisCount = 3;

              return GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: areas.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 2.0,
                ),
                itemBuilder: (context, index) {
                  final area = areas[index];
                  return Card(
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: const CircleAvatar(child: Icon(Icons.map)),
                      title: Text(
                        area.areaName ?? 'Unknown',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () =>
                                _showEditDialog(context, ref, area),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _confirmDelete(context, ref, area),
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
      ),
    );
  }

  void _showEditDialog(BuildContext context, WidgetRef ref, Area? area) {
    final nameController = TextEditingController(text: area?.areaName ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(area == null ? 'Add Area' : 'Edit Area'),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(labelText: 'Area Name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                if (area != null) {
                  area.areaName = nameController.text;
                  ref.read(appRepositoryProvider).saveArea(area);
                } else {
                  final newArea = Area(areaName: nameController.text);
                  ref.read(appRepositoryProvider).saveArea(newArea);
                }
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, Area area) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Area'),
        content: Text('Delete ${area.areaName}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(appRepositoryProvider).deleteArea(area.id);
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
