import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/repositories/app_repository.dart';
import '../../../../core/models/contractor.dart';

class ContractorTab extends ConsumerWidget {
  const ContractorTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contractorsStream = ref
        .watch(appRepositoryProvider)
        .watchContractors();

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showEditDialog(context, ref, null);
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<Contractor>>(
        stream: contractorsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final contractors = snapshot.data ?? [];

          if (contractors.isEmpty) {
            return const Center(child: Text('No contractors found.'));
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              int crossAxisCount = 1;
              if (width > 600) crossAxisCount = 2;
              if (width > 900) crossAxisCount = 3;

              return GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: contractors.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 2.0,
                ),
                itemBuilder: (context, index) {
                  final contractor = contractors[index];
                  return Card(
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: const CircleAvatar(child: Icon(Icons.business)),
                      title: Text(
                        contractor.name ?? 'Unknown',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () =>
                                _showEditDialog(context, ref, contractor),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () =>
                                _confirmDelete(context, ref, contractor),
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
    Contractor? contractor,
  ) {
    final nameController = TextEditingController(text: contractor?.name ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(contractor == null ? 'Add Contractor' : 'Edit Contractor'),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(labelText: 'Name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final newName = nameController.text;
              if (newName.isNotEmpty) {
                // Isar update: if id exists, it updates.
                // However, contractor from stream is managed.
                if (contractor != null) {
                  contractor.name = newName;
                  ref.read(appRepositoryProvider).saveContractor(contractor);
                } else {
                  final newC = Contractor(name: newName);
                  ref.read(appRepositoryProvider).saveContractor(newC);
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
    Contractor contractor,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Contractor'),
        content: Text('Delete ${contractor.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(appRepositoryProvider).deleteContractor(contractor.id);
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
