import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/repositories/app_repository.dart';
import '../../../../core/models/person.dart';
import '../../../../core/state/auth_state.dart';
import '../../../../features/home/widgets/person_edit_dialog.dart';
import 'person_card_widget.dart';

class PersonTab extends ConsumerStatefulWidget {
  const PersonTab({super.key});

  @override
  ConsumerState<PersonTab> createState() => _PersonTabState();
}

class _PersonTabState extends ConsumerState<PersonTab> {
  String _selectedFilter = 'ALL'; // ALL, SPOT, CRUMBLING

  @override
  Widget build(BuildContext context) {
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

        List<Person> persons = snapshot.data ?? [];

        // Apply Filter
        if (_selectedFilter != 'ALL') {
          persons = persons.where((p) {
            final preset = p.preset?.toUpperCase() ?? '';
            return preset == _selectedFilter;
          }).toList();
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            // Adjust columns based on width
            int crossAxisCount = 2; // Mobile
            if (width > 600) crossAxisCount = 3; // Tablet
            if (width > 900) crossAxisCount = 4; // Desktop
            if (width > 1400) crossAxisCount = 5; // Large Desktop

            // Dynamic Aspect Ratio
            // Calculate available width per item
            double totalSpacing =
                (crossAxisCount - 1) * 16 + 32; // 16 spacing + 32 padding
            double itemWidth = (width - totalSpacing) / crossAxisCount;
            // Target height around 280-300px
            double targetHeight = 310;
            double childAspectRatio = itemWidth / targetHeight;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Filters Aligned Left
                      Row(
                        children: [
                          _buildFilterTab('ALL UNITS', 'ALL'),
                          const SizedBox(width: 12),
                          _buildFilterTab('SPOT', 'SPOT'),
                          const SizedBox(width: 12),
                          _buildFilterTab('CRUMBLING', 'CRUMBLING'),
                        ],
                      ),

                      ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                const PersonEditDialog(person: null),
                          );
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('REGISTER OPERATOR'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2ECC71),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                if (persons.isEmpty)
                  Expanded(
                    child: Center(
                      child: Text(
                        _selectedFilter == 'ALL'
                            ? 'No persons found.'
                            : 'No persons found for this filter.',
                        style: const TextStyle(color: Colors.white54),
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      itemCount: persons.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: childAspectRatio,
                      ),
                      itemBuilder: (context, index) {
                        final person = persons[index];
                        return PersonCardWidget(
                          person: person,
                          showDelete: _canDelete(currentUser, person),
                          onEdit: () {
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  PersonEditDialog(person: person),
                            );
                          },
                          onDelete: () {
                            _confirmDelete(context, ref, person);
                          },
                        );
                      },
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  // Helper for top filter buttons (Green capsule style)
  Widget _buildFilterButton(String label, String value) {
    // Deprecated in favor of _buildFilterTab below to match image more closely?
    // The image shows "ALL UNITS", "EXCAVATORS"... in a row of capsules.
    return Container();
  }

  Widget _buildFilterTab(String label, String value) {
    bool isSelected = _selectedFilter == value;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedFilter = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2ECC71) : const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? null : Border.all(color: Colors.white24),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
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
        backgroundColor: const Color(0xFF0F1410),
        title: const Text(
          'Delete Operator',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Are you sure you want to delete ${person.firstName}?',
          style: const TextStyle(color: Colors.white70),
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
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await ref.read(appRepositoryProvider).deletePerson(person.id);
    }
  }
}
