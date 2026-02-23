import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/repositories/app_repository.dart';
import '../../../../core/models/contractor.dart';
import 'contractor_card_widget.dart';

class ContractorTab extends ConsumerWidget {
  const ContractorTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contractorsStream = ref
        .watch(appRepositoryProvider)
        .watchContractors();

    return StreamBuilder<List<Contractor>>(
      stream: contractorsStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final contractors = snapshot.data ?? [];

        return LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            int crossAxisCount = 2;
            if (width > 700) crossAxisCount = 3;
            if (width > 1000) crossAxisCount = 4;
            if (width > 1400) crossAxisCount = 5;

            // Dynamic aspect ratio
            double totalSpacing = (crossAxisCount - 1) * 16 + 32;
            double itemWidth = (width - totalSpacing) / crossAxisCount;
            double childAspectRatio = itemWidth / 270;

            return Column(
              children: [
                // Toolbar
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => _showEditDialog(context, ref, null),
                        icon: const Icon(Icons.add),
                        label: const Text('ADD CONTRACTOR'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2ECC71),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                if (contractors.isEmpty)
                  const Expanded(
                    child: Center(
                      child: Text(
                        'No contractors found.',
                        style: TextStyle(color: Colors.white54),
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      itemCount: contractors.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: childAspectRatio,
                      ),
                      itemBuilder: (context, index) {
                        final contractor = contractors[index];
                        return ContractorCardWidget(
                          contractor: contractor,
                          onEdit: () =>
                              _showEditDialog(context, ref, contractor),
                          onDelete: () =>
                              _confirmDelete(context, ref, contractor),
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

  void _showEditDialog(
    BuildContext context,
    WidgetRef ref,
    Contractor? contractor,
  ) {
    showDialog(
      context: context,
      builder: (context) =>
          _ContractorEditDialog(contractor: contractor, ref: ref),
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
        backgroundColor: const Color(0xFF0F1410),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFF1E3A2A)),
        ),
        title: const Text(
          'Delete Contractor',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Are you sure you want to delete "${contractor.name}"?',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white54),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(appRepositoryProvider).deleteContractor(contractor.id);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

// ─── Separate stateful dialog widget ────────────────────────────────────────

class _ContractorEditDialog extends StatefulWidget {
  final Contractor? contractor;
  final WidgetRef ref;

  const _ContractorEditDialog({required this.contractor, required this.ref});

  @override
  State<_ContractorEditDialog> createState() => _ContractorEditDialogState();
}

class _ContractorEditDialogState extends State<_ContractorEditDialog> {
  late TextEditingController _nameController;
  late TextEditingController _sectorController;
  late TextEditingController _areaController;
  late TextEditingController _numEquipmentController;
  late TextEditingController _numOperatorController;

  @override
  void initState() {
    super.initState();
    final c = widget.contractor;
    _nameController = TextEditingController(text: c?.name ?? '');
    _sectorController = TextEditingController(text: c?.sector ?? '');
    _areaController = TextEditingController(text: c?.area ?? '');
    _numEquipmentController = TextEditingController(
      text: c?.numberEquipment?.toStringAsFixed(0) ?? '',
    );
    _numOperatorController = TextEditingController(
      text: c?.numberOperator?.toStringAsFixed(0) ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _sectorController.dispose();
    _areaController.dispose();
    _numEquipmentController.dispose();
    _numOperatorController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    final now = DateTime.now();
    final contractorToSave = widget.contractor ?? Contractor();

    contractorToSave
      ..uid = now.millisecondsSinceEpoch.toString()
      ..name = name
      ..sector = _sectorController.text.trim()
      ..area = _areaController.text.trim()
      ..numberEquipment = double.tryParse(_numEquipmentController.text) ?? 0
      ..numberOperator = double.tryParse(_numOperatorController.text) ?? 0
      ..lastUpdate = now.millisecondsSinceEpoch;

    await widget.ref
        .read(appRepositoryProvider)
        .saveContractor(contractorToSave);

    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.contractor != null;

    return Dialog(
      backgroundColor: const Color(0xFF0F1410),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFF1E3A2A)),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        width: 520,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.business, color: Color(0xFF2ECC71)),
                    const SizedBox(width: 12),
                    Text(
                      isEdit ? 'EDIT CONTRACTOR' : 'ADD CONTRACTOR',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close, color: Colors.white54),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(color: Color(0xFF1E3A2A)),
            const SizedBox(height: 16),

            // Form fields
            _buildField('NAME', _nameController, hint: 'e.g. PT. Maju Jaya'),
            const SizedBox(height: 16),
            _buildField('SECTOR', _sectorController, hint: 'e.g. Mining'),
            const SizedBox(height: 16),
            _buildField('AREA', _areaController, hint: 'e.g. Block A'),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildField(
                    'NUMBER OF EQUIPMENT',
                    _numEquipmentController,
                    hint: '0',
                    isNumber: true,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildField(
                    'NUMBER OF OPERATORS',
                    _numOperatorController,
                    hint: '0',
                    isNumber: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white24),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('CANCEL'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _save,
                    icon: const Icon(Icons.save_outlined, size: 16),
                    label: const Text('SAVE'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2ECC71),
                      foregroundColor: Colors.black,
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(
    String label,
    TextEditingController controller, {
    String? hint,
    bool isNumber = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF2ECC71),
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          inputFormatters: isNumber
              ? [FilteringTextInputFormatter.digitsOnly]
              : null,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black26,
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white24),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.white10),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.white10),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF2ECC71)),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }
}
