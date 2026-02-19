import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
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
      appBar: AppBar(title: const Text('Create Workfile')),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Area Dropdown
                  DropdownButtonFormField<Area>(
                    decoration: const InputDecoration(labelText: 'Area'),
                    value: state.selectedArea,
                    items: state.areas.map((area) {
                      return DropdownMenuItem(
                        value: area,
                        child: Text(area.areaName ?? 'Unnamed Area'),
                      );
                    }).toList(),
                    onChanged: (value) => notifier.selectArea(value),
                  ),
                  const SizedBox(height: 16),

                  // Contractor Dropdown
                  DropdownButtonFormField<Contractor>(
                    decoration: const InputDecoration(labelText: 'Contractor'),
                    value: state.selectedContractor,
                    items: state.contractors.map((contractor) {
                      return DropdownMenuItem(
                        value: contractor,
                        child: Text(contractor.name ?? 'Unnamed Contractor'),
                      );
                    }).toList(),
                    onChanged: (value) => notifier.selectContractor(value),
                  ),
                  const SizedBox(height: 16),

                  // System Mode Dropdown
                  DropdownButtonFormField<SystemMode>(
                    decoration: const InputDecoration(labelText: 'System Mode'),
                    value: state.selectedMode,
                    items: SystemMode.values.map((mode) {
                      return DropdownMenuItem(
                        value: mode,
                        child: Text(mode.name.toUpperCase()),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) notifier.selectMode(value);
                    },
                  ),
                  const SizedBox(height: 16),

                  // Spacing Dropdown
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Spacing'),
                    value: state.selectedSpacing,
                    items: ['4x1.87', '4x1.5', '3x2', '3x2.5'].map((spacing) {
                      return DropdownMenuItem(
                        value: spacing,
                        child: Text(spacing),
                      );
                    }).toList(),
                    onChanged: (value) => notifier.selectSpacing(value),
                  ),
                  const SizedBox(height: 24),

                  // File Input
                  ElevatedButton.icon(
                    onPressed: () => notifier.pickFile(),
                    icon: const Icon(Icons.upload_file),
                    label: const Text('Select GeoJSON File'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                    ),
                  ),
                  if (state.filePath != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Selected: ${state.filePath!.split('/').last}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),

                  const SizedBox(height: 24),

                  // Summary
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Total Spots:'),
                              Text(
                                '${state.parsedSpots.length}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Calculated Area:'),
                              Text(
                                '${state.computedArea?.toStringAsFixed(2) ?? 0} Ha',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Save Button
                  SizedBox(
                    width: double.infinity,
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
                                  const SnackBar(
                                    content: Text(
                                      'Workfile created successfully',
                                    ),
                                  ),
                                );
                              }
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('CREATE WORKFILE'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
