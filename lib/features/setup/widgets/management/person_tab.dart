import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/repositories/app_repository.dart';
import '../../../../core/models/person.dart';
import '../../../../core/state/auth_state.dart';
import '../../../../features/home/widgets/person_edit_dialog.dart';

class PersonTab extends ConsumerWidget {
  const PersonTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personsStream = ref.watch(appRepositoryProvider).watchPersons();
    final currentUser = ref.watch(authProvider).currentUser;

    return StreamBuilder<List<Person>>(
      stream: personsStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final persons = snapshot.data ?? [];

        if (persons.isEmpty) {
          return const Center(child: Text('No persons found.'));
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            // Responsive Grid
            final width = constraints.maxWidth;
            int crossAxisCount = 1;
            if (width > 600) crossAxisCount = 2;
            if (width > 900) crossAxisCount = 3;

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: persons.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.5,
              ),
              itemBuilder: (context, index) {
                final person = persons[index];
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
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: person.picURL != null
                                  ? AssetImage(person.picURL!)
                                  : null,
                              child: person.picURL == null
                                  ? const Icon(Icons.person)
                                  : null,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${person.firstName} ${person.lastName}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    person.role ?? 'Unknown Role',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        Text('ID: ${person.driverID ?? '-'}'),
                        Text('Contractor: ${person.kontraktor ?? '-'}'),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      PersonEditDialog(person: person),
                                );
                              },
                            ),
                            if (_canDelete(currentUser, person))
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  _confirmDelete(context, ref, person);
                                },
                              ),
                          ],
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

  bool _canDelete(Person? currentUser, Person targetPerson) {
    if (currentUser == null) return false;
    // Only Admin can delete
    if (currentUser.role != 'admin') return false;
    // Admin cannot delete self
    if (currentUser.uid == targetPerson.uid) return false;

    return true;
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    Person person,
  ) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Person'),
        content: Text('Are you sure you want to delete ${person.firstName}?'),
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
      await ref.read(appRepositoryProvider).deletePerson(person.id);
    }
  }
}
