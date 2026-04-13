import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/repositories/app_repository.dart';
import '../../../../core/models/area.dart';
import '../../../../core/utils/app_theme.dart';
import 'area_card_widget.dart';

class AreaTab extends ConsumerWidget {
  const AreaTab({super.key});

  static const List<String> _spacingOptions = [
    '4x1.87',
    '4x1.5',
    '3x2.5',
    '3x2',
    '2.5x2.5',
    '5x2',
    '6x2',
    'Custom',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final areasStream = ref.watch(appRepositoryProvider).watchAreas();

    return StreamBuilder<List<Area>>(
      stream: areasStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final areas = snapshot.data ?? [];

        return LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            int crossAxisCount = 2;
            if (width > 700) crossAxisCount = 3;
            if (width > 1000) crossAxisCount = 4;
            if (width > 1400) crossAxisCount = 5;

            double totalSpacing = (crossAxisCount - 1) * 16 + 32;
            double itemWidth = (width - totalSpacing) / crossAxisCount;
            double childAspectRatio = itemWidth / 230;

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
                        label: const Text('ADD AREA'),
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

                if (areas.isEmpty)
                  const Expanded(
                    child: Center(
                      child: Text(
                        'No areas found.',
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
                      itemCount: areas.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: childAspectRatio,
                      ),
                      itemBuilder: (context, index) {
                        final area = areas[index];
                        return AreaCardWidget(
                          area: area,
                          onEdit: () => _showEditDialog(context, ref, area),
                          onDelete: () => _confirmDelete(context, ref, area),
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

  void _showEditDialog(BuildContext context, WidgetRef ref, Area? area) {
    showDialog(
      context: context,
      builder: (context) => _AreaEditDialog(
        area: area,
        ref: ref,
        spacingOptions: _spacingOptions,
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, Area area) {
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
          title: Text(
            'Delete Area',
            style: TextStyle(color: theme.textOnSurface),
          ),
          content: Text(
            'Are you sure you want to delete "${area.areaName}"?',
            style: TextStyle(color: theme.textSecondary),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(color: theme.textSecondary),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(appRepositoryProvider).deleteArea(area.id);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEF4444),
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}

// ─── Separate stateful dialog widget ────────────────────────────────────────

class _AreaEditDialog extends StatefulWidget {
  final Area? area;
  final WidgetRef ref;
  final List<String> spacingOptions;

  const _AreaEditDialog({
    required this.area,
    required this.ref,
    required this.spacingOptions,
  });

  @override
  State<_AreaEditDialog> createState() => _AreaEditDialogState();
}

class _AreaEditDialogState extends State<_AreaEditDialog> {
  late TextEditingController _areaNameController;
  late TextEditingController _luasAreaController;
  late TextEditingController _targetDoneController;
  String? _selectedSpacing;

  @override
  void initState() {
    super.initState();
    final a = widget.area;
    _areaNameController = TextEditingController(text: a?.areaName ?? '');
    _luasAreaController = TextEditingController(
      text: a?.luasArea?.toString() ?? '',
    );
    _targetDoneController = TextEditingController(
      text: a?.targetDone?.toString() ?? '',
    );
    _selectedSpacing = a?.spacing;
  }

  @override
  void dispose() {
    _areaNameController.dispose();
    _luasAreaController.dispose();
    _targetDoneController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = _areaNameController.text.trim();
    if (name.isEmpty) return;

    final now = DateTime.now();
    final areaToSave = widget.area ?? Area();

    areaToSave
      // ..uid = now.millisecondsSinceEpoch.toString()
      ..areaName = name
      ..luasArea = double.tryParse(_luasAreaController.text) ?? 0
      ..targetDone = int.tryParse(_targetDoneController.text) ?? 0
      ..spacing = _selectedSpacing
      ..lastUpdate = now.millisecondsSinceEpoch ~/ 1000;

    await widget.ref.read(appRepositoryProvider).saveArea(areaToSave);
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.area != null;
    final theme = AppTheme.of(context);

    return Dialog(
      backgroundColor: theme.dialogBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.cardBorderColor),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        width: 480,
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
                    Icon(Icons.terrain, color: theme.appBarAccent),
                    const SizedBox(width: 12),
                    Text(
                      isEdit ? 'EDIT AREA' : 'ADD AREA',
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
            _buildField(
              theme,
              'AREA NAME',
              _areaNameController,
              hint: 'e.g. Block A - North',
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildField(
                    theme,
                    'LUAS AREA (Ha)',
                    _luasAreaController,
                    hint: 'e.g. 25.5',
                    isDecimal: true,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildField(
                    theme,
                    'TARGET SELESAI (Days)',
                    _targetDoneController,
                    hint: 'e.g. 30',
                    isInteger: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildDropdown(
              theme,
              'SPACING',
              widget.spacingOptions,
              _selectedSpacing,
              (v) => setState(() => _selectedSpacing = v),
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
                      backgroundColor: theme.primaryButtonBackground,
                      foregroundColor: theme.primaryButtonText,
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
    AppThemeData theme,
    String label,
    TextEditingController controller, {
    String? hint,
    bool isDecimal = false,
    bool isInteger = false,
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
              : isInteger
              ? TextInputType.number
              : TextInputType.text,
          inputFormatters: isDecimal
              ? [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))]
              : isInteger
              ? [FilteringTextInputFormatter.digitsOnly]
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
            'Select spacing...',
            style: TextStyle(color: theme.textSecondary),
          ),
          items: items
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
