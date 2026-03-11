import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:file_picker/file_picker.dart';
import '../../core/models/area.dart';
import '../../core/models/contractor.dart';
import '../../core/state/auth_state.dart';
import 'workfile_presenter.dart';

class CreateWorkfilePage extends ConsumerStatefulWidget {
  const CreateWorkfilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateWorkfilePage> createState() => _CreateWorkfilePageState();
}

class _CreateWorkfilePageState extends ConsumerState<CreateWorkfilePage> {
  @override
  void initState() {
    super.initState();
    // Load initial data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(workfilePresenterProvider.notifier).loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(workfilePresenterProvider);
    final notifier = ref.read(workfilePresenterProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFF121612), // Darker green-black
      appBar: AppBar(
        title: const Text(
          'Create Workfile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1E241E),
        iconTheme: const IconThemeData(color: Colors.greenAccent),
        elevation: 0,
      ),
      body: state.isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.greenAccent),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Area Dropdown
                      _buildDropdown<Area>(
                        label: 'SELECT AREA',
                        value: state.selectedArea,
                        items: state.areas
                            .map(
                              (a) => DropdownMenuItem(
                                value: a,
                                child: Text(a.areaName ?? 'Unnamed Area'),
                              ),
                            )
                            .toList(),
                        onChanged: (value) => notifier.selectArea(value),
                      ),
                      const SizedBox(height: 20),

                      // Contractor Dropdown
                      _buildDropdown<Contractor>(
                        label: 'SELECT CONTRACTOR',
                        value: state.selectedContractor,
                        items: state.contractors
                            .map(
                              (c) => DropdownMenuItem(
                                value: c,
                                child: Text(c.name ?? 'Unnamed Contractor'),
                              ),
                            )
                            .toList(),
                        onChanged: (value) => notifier.selectContractor(value),
                      ),
                      const SizedBox(height: 20),

                      // System Mode Dropdown
                      _buildDropdown<SystemMode>(
                        label: 'SYSTEM MODE',
                        value: state.selectedMode,
                        items: SystemMode.values
                            .map(
                              (m) => DropdownMenuItem(
                                value: m,
                                child: Text(m.name.toUpperCase()),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value != null) notifier.selectMode(value);
                        },
                      ),
                      const SizedBox(height: 20),

                      // Spacing Dropdown
                      _buildDropdown<String>(
                        label: 'SPACING',
                        value: state.selectedSpacing,
                        items: ['4x1.87', '4x1.5', '3x2', '3x2.5']
                            .map(
                              (s) => DropdownMenuItem(value: s, child: Text(s)),
                            )
                            .toList(),
                        onChanged: (value) => notifier.selectSpacing(value),
                      ),
                      const SizedBox(height: 32),

                      // File Input
                      Text(
                        'GEOJSON FILE',
                        style: TextStyle(
                          color: Colors.greenAccent[400],
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton.icon(
                        onPressed: () => notifier.pickFile(),
                        icon: const Icon(Icons.upload_file),
                        label: const Text('SELECT GEOJSON FILE'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.05),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(color: Colors.white24),
                          ),
                          elevation: 0,
                        ),
                      ),
                      if (state.filePath != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Text(
                            'Selected: ${state.filePath!.split('/').last}',
                            style: const TextStyle(
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                      const SizedBox(height: 32),

                      // Summary Card
                      Container(
                        padding: const EdgeInsets.all(24.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E241E),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            _buildSummaryRow(
                              'Total Spots:',
                              '${state.parsedSpots.length}',
                            ),
                            const SizedBox(height: 12),
                            _buildSummaryRow(
                              'Calculated Area:',
                              '${state.computedArea?.toStringAsFixed(2) ?? 0} Ha',
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 48),

                      // Save Button
                      SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          onPressed:
                              (state.selectedArea != null &&
                                  state.selectedContractor != null &&
                                  state.parsedSpots.isNotEmpty)
                              ? () async {
                                  final success = await notifier.saveWorkfile();
                                  if (success && context.mounted) {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text(
                                          'Workfile created successfully',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        backgroundColor:
                                            Colors.greenAccent[700],
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  }
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.greenAccent[700],
                            foregroundColor: Colors.black,
                            disabledBackgroundColor: Colors.white10,
                            disabledForegroundColor: Colors.white30,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'CREATE WORKFILE',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildDropdown<T>({
    required String label,
    required T? value,
    required List<DropdownMenuItem<T>> items,
    required void Function(T?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.greenAccent[400],
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white24),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              hint: const Text(
                'Select an option',
                style: TextStyle(color: Colors.white54),
              ),
              dropdownColor: const Color(0xFF1E241E),
              icon: const Icon(Icons.expand_more, color: Colors.greenAccent),
              style: const TextStyle(color: Colors.white, fontSize: 16),
              isExpanded: true,
              items: items,
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 16),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
