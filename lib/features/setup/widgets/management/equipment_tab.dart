import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/repositories/app_repository.dart';
import '../../../../core/models/equipment.dart';
import '../../../../core/utils/app_theme.dart';
import 'equipment_card_widget.dart';

class EquipmentTab extends ConsumerWidget {
  const EquipmentTab({super.key});

  static const List<String> _models = [
    'Hitachi',
    'Komatsu',
    'Sunny',
    'Caterpillar',
    'Volvo',
    'Doosan',
    'Sany',
    'Other',
  ];

  static const List<String> _types = [
    'Excavator',
    'Dozer',
    'Grader',
    'Truck',
    'Compactor',
    'Wheel Loader',
    'Crane',
    'Other',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final equipmentsStream = ref.watch(appRepositoryProvider).watchEquipments();

    return StreamBuilder<List<Equipment>>(
      stream: equipmentsStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final equipments = snapshot.data ?? [];

        return LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            int crossAxisCount = 2;
            if (width > 700) crossAxisCount = 3;
            if (width > 1000) crossAxisCount = 4;
            if (width > 1400) crossAxisCount = 5;

            double totalSpacing = (crossAxisCount - 1) * 16 + 32;
            double itemWidth = (width - totalSpacing) / crossAxisCount;
            double childAspectRatio = itemWidth / 260;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => _showEditDialog(context, ref, null),
                        icon: const Icon(Icons.add),
                        label: const Text('ADD EQUIPMENT'),
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

                if (equipments.isEmpty)
                  Expanded(
                    child: Center(
                      child: Builder(builder: (ctx) {
                        final theme = AppTheme.of(ctx);
                        return Text(
                          'No equipment found.',
                          style: TextStyle(color: theme.textSecondary),
                        );
                      }),
                    ),
                  )
                else
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      itemCount: equipments.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: childAspectRatio,
                      ),
                      itemBuilder: (context, index) {
                        final equipment = equipments[index];
                        return EquipmentCardWidget(
                          equipment: equipment,
                          onEdit: () =>
                              _showEditDialog(context, ref, equipment),
                          onDelete: () =>
                              _confirmDelete(context, ref, equipment),
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
    Equipment? equipment,
  ) {
    showDialog(
      context: context,
      builder: (context) => _EquipmentEditDialog(
        equipment: equipment,
        ref: ref,
        models: _models,
        types: _types,
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
      builder: (context) {
        final theme = AppTheme.of(context);
        return AlertDialog(
          backgroundColor: theme.dialogBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: theme.cardBorderColor),
          ),
          title: Text('Delete Equipment',
              style: TextStyle(color: theme.textOnSurface)),
          content: Text(
            'Are you sure you want to delete "${equipment.equipName ?? equipment.unitNumber}"?',
            style: TextStyle(color: theme.textSecondary),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel',
                  style: TextStyle(color: theme.textSecondary)),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(appRepositoryProvider).deleteEquipment(equipment.id);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEF4444)),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}

// ─── Separate stateful dialog widget ────────────────────────────────────────

class _EquipmentEditDialog extends StatefulWidget {
  final Equipment? equipment;
  final WidgetRef ref;
  final List<String> models;
  final List<String> types;

  const _EquipmentEditDialog({
    required this.equipment,
    required this.ref,
    required this.models,
    required this.types,
  });

  @override
  State<_EquipmentEditDialog> createState() => _EquipmentEditDialogState();
}

class _EquipmentEditDialogState extends State<_EquipmentEditDialog> {
  late TextEditingController _equipNameController;
  late TextEditingController _partNameController;
  late TextEditingController _unitNumberController;
  late TextEditingController _armLengthController;
  String? _selectedModel;
  String? _selectedType;

  @override
  void initState() {
    super.initState();
    final e = widget.equipment;
    _equipNameController = TextEditingController(text: e?.equipName ?? '');
    _partNameController = TextEditingController(text: e?.partName ?? '');
    _unitNumberController = TextEditingController(text: e?.unitNumber ?? '');
    _armLengthController = TextEditingController(
      text: e?.armLength?.toString() ?? '',
    );
    _selectedModel = e?.model;
    _selectedType = e?.type;
  }

  @override
  void dispose() {
    _equipNameController.dispose();
    _partNameController.dispose();
    _unitNumberController.dispose();
    _armLengthController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final now = DateTime.now();
    final equipToSave = widget.equipment ?? Equipment();

    equipToSave
      ..uid = now.millisecondsSinceEpoch.toString()
      ..equipName = _equipNameController.text.trim()
      ..partName = _partNameController.text.trim()
      ..unitNumber = _unitNumberController.text.trim()
      ..armLength = double.tryParse(_armLengthController.text)
      ..model = _selectedModel
      ..type = _selectedType
      ..lastUpdate = now.millisecondsSinceEpoch;
    // lastDriver and ipAddress left empty as requested

    await widget.ref.read(appRepositoryProvider).saveEquipment(equipToSave);
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.equipment != null;
    final theme = AppTheme.of(context);

    return Dialog(
      backgroundColor: theme.dialogBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.cardBorderColor),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        width: 580,
        child: SingleChildScrollView(
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
                      Icon(Icons.handyman, color: theme.appBarAccent),
                      const SizedBox(width: 12),
                      Text(
                        isEdit ? 'EDIT EQUIPMENT' : 'ADD EQUIPMENT',
                        style: TextStyle(
                          color: theme.textOnSurface,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close, color: theme.textSecondary),
                  ),
                ],
              ),
              Divider(color: theme.dividerColor),
              const SizedBox(height: 16),

              // Row 1: equip name + part name
              Row(
                children: [
                  Expanded(
                    child: _buildField(theme, 'EQUIP NAME',
                        _equipNameController, hint: 'e.g. PC200'),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildField(theme, 'PART NAME',
                        _partNameController, hint: 'e.g. Bucket'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildField(theme, 'UNIT NUMBER',
                        _unitNumberController, hint: 'e.g. EX-001'),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildField(theme, 'ARM LENGTH (m)',
                        _armLengthController,
                        hint: 'e.g. 5.5', isDecimal: true),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildDropdown(theme, 'MODEL', widget.models,
                        _selectedModel,
                        (v) => setState(() => _selectedModel = v)),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildDropdown(theme, 'TYPE', widget.types,
                        _selectedType,
                        (v) => setState(() => _selectedType = v)),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: theme.textOnSurface,
                        side: BorderSide(color: theme.dividerColor),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
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
                        backgroundColor: theme.primaryButtonBackground,
                        foregroundColor: theme.primaryButtonText,
                        textStyle:
                            const TextStyle(fontWeight: FontWeight.bold),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(
    AppThemeData theme,
    String label,
    TextEditingController controller, {
    String? hint,
    bool isDecimal = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: theme.appBarAccent,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          style: TextStyle(color: theme.textOnSurface),
          keyboardType: isDecimal
              ? const TextInputType.numberWithOptions(decimal: true)
              : TextInputType.text,
          inputFormatters: isDecimal
              ? [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))]
              : null,
          decoration: InputDecoration(
            filled: true,
            fillColor: theme.inputFill,
            hintText: hint,
            hintStyle: TextStyle(color: theme.textSecondary),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: theme.inputBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: theme.inputBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: theme.appBarAccent),
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

  Widget _buildDropdown(
    AppThemeData theme,
    String label,
    List<String> items,
    String? value,
    void Function(String?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: theme.appBarAccent,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          dropdownColor: theme.dropdownBackground,
          style: TextStyle(color: theme.dropdownItemText),
          decoration: InputDecoration(
            filled: true,
            fillColor: theme.inputFill,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: theme.inputBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: theme.inputBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: theme.appBarAccent),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
          hint: Text(
            'Select...',
            style: TextStyle(color: theme.textSecondary),
          ),
          items: items
              .map((item) =>
                  DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
