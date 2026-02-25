import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../dashboard_presenter.dart';

class DashboardHeader extends ConsumerStatefulWidget {
  const DashboardHeader({super.key});

  @override
  ConsumerState<DashboardHeader> createState() => _DashboardHeaderState();
}

class _DashboardHeaderState extends ConsumerState<DashboardHeader> {
  String selectedWorkfile = 'WF-2023-001';

  final List<String> workfiles = [
    'WF-2023-001',
    'WF-2023-002',
    'Project-Alpha',
    'Site-B-Grounding',
  ];

  @override
  Widget build(BuildContext context) {
    // Read current state from presenter
    final presenter = ref.read(dashboardPresenterProvider.notifier);

    // Watch provider to get current filter status
    ref.watch(dashboardPresenterProvider);
    final filter = presenter.filter;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Filters & Controls Row (Responsive wrapping)
        LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Left Group: Filter Tabs + Custom Date Range Picker
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Time Filter Segmented Control
                        Container(
                          height: 44, // Fixed height to match others
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E293B),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFF1E3A2A)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildFilterChip(
                                'Morning',
                                DashboardFilterType.morning,
                                presenter,
                              ),
                              _buildFilterChip(
                                'Night',
                                DashboardFilterType.night,
                                presenter,
                              ),
                              _buildFilterChip(
                                'Weekly',
                                DashboardFilterType.weekly,
                                presenter,
                              ),
                              _buildFilterChip(
                                'Monthly',
                                DashboardFilterType.monthly,
                                presenter,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),

                        // Custom Filter Button (to enable Range Picker)
                        Container(
                          height: 44, // Matched height
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E293B),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFF1E3A2A)),
                          ),
                          child: IconButton(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            constraints:
                                const BoxConstraints(), // Remove default minimum constraints
                            tooltip: "Custom Range",
                            onPressed: () async {
                              final picked = await showDateRangePicker(
                                context: context,
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2030),
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: const ColorScheme.dark(
                                        primary: const Color(0xFF2ECC71),
                                        onPrimary: Colors.black,
                                        surface: const Color(0xFF0F1410),
                                        onSurface: Colors.white,
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              if (picked != null) {
                                presenter.updateCustomRange(picked);
                              }
                            },
                            icon: Icon(
                              Icons.date_range,
                              size: 20,
                              color: filter.type == DashboardFilterType.custom
                                  ? const Color(0xFF2ECC71)
                                  : Colors.white54,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(width: 16),

                    // Right Group: Workfile Dropdown
                    Container(
                      height: 44, // Matched height
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E293B),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF1E3A2A)),
                      ),
                      alignment: Alignment.center,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedWorkfile,
                          dropdownColor: const Color(0xFF1E293B),
                          icon: const Icon(
                            Icons.folder_open_outlined,
                            color: Colors.white54,
                            size: 20,
                          ),
                          isDense: true, // Reduce default height
                          items: workfiles.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            if (newValue != null) {
                              setState(() => selectedWorkfile = newValue);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildFilterChip(
    String label,
    DashboardFilterType type,
    DashboardPresenter presenter,
  ) {
    bool isSelected = presenter.filter.type == type;
    return GestureDetector(
      onTap: () => presenter.updateFilterType(type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2ECC71) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label.toUpperCase(),
          style: TextStyle(
            color: isSelected ? Colors.black : const Color(0xFFB0BEC5),
            fontWeight: FontWeight.bold,
            fontSize: 12,
            letterSpacing: 0.8,
          ),
        ),
      ),
    );
  }
}
