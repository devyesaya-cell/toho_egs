import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/repositories/app_repository.dart';
import '../../../../core/models/equipment.dart';

class EquipmentTab extends ConsumerWidget {
  const EquipmentTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final equipmentsStream = ref.watch(appRepositoryProvider).watchEquipments();

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showEditDialog(context, ref, null);
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<Equipment>>(
        stream: equipmentsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final equipments = snapshot.data ?? [];

          if (equipments.isEmpty) {
            return const Center(child: Text('No equipment found.'));
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              int crossAxisCount = 1;
              if (width > 600) crossAxisCount = 2;
              if (width > 900) crossAxisCount = 3;

              return GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: equipments.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 2.0,
                ),
                itemBuilder: (context, index) {
                  final equipment = equipments[index];
                  return Card(
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: const CircleAvatar(child: Icon(Icons.handyman)),
                      title: Text(
                        equipment.unitNumber ?? 'Unknown',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(equipment.model ?? ''),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () =>
                                _showEditDialog(context, ref, equipment),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () =>
                                _confirmDelete(context, ref, equipment),
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

  void _showEditDialog(
    BuildContext context,
    WidgetRef ref,
    Equipment? equipment,
  ) {
    final unitController = TextEditingController(
      text: equipment?.unitNumber ?? '',
    );
    final modelController = TextEditingController(text: equipment?.model ?? '');
    final ipController = TextEditingController(
      text: equipment?.ipAddress ?? '',
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(equipment == null ? 'Add Equipment' : 'Edit Equipment'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: unitController,
              decoration: const InputDecoration(labelText: 'Unit Number'),
            ),
            TextField(
              controller: modelController,
              decoration: const InputDecoration(labelText: 'Model'),
            ),
            TextField(
              controller: ipController,
              decoration: const InputDecoration(labelText: 'IP Address'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (unitController.text.isNotEmpty) {
                if (equipment != null) {
                  equipment.unitNumber = unitController.text;
                  equipment.model = modelController.text;
                  equipment.ipAddress = ipController.text;
                  ref.read(appRepositoryProvider).saveEquipment(equipment);
                } else {
                  final newEq = Equipment(
                    unitNumber: unitController.text,
                    model: modelController.text,
                    ipAddress: ipController.text,
                  );
                  ref.read(appRepositoryProvider).saveEquipment(newEq);
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

  void _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    Equipment equipment,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Equipment'),
        content: Text('Delete ${equipment.unitNumber}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(appRepositoryProvider).deleteEquipment(equipment.id);
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
