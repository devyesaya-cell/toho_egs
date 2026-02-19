
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    'Site-B-Grounding'
  ];

  @override
  Widget build(BuildContext context) {
    // Read current state from presenter
    final presenter = ref.read(dashboardPresenterProvider.notifier);
    
    // Watch provider to get current filter status (indirectly via data? No, presenter has getters)
    // Actually, AsyncNotifier doesn't expose properties directly via watch, only the state.
    // To solve this properly, we should usually split state.
    // BUT since we put a 'get filter' in the presenter, we can access it via the notifier.
    // However, changes to 'filter' won't trigger rebuilds unless 'state' changes.
    // 'refresh()' in presenter updates state, so this widget will rebuild if it watches the provider.
    ref.watch(dashboardPresenterProvider); 
    final filter = presenter.filter;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Dashboard',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {}, 
              style: IconButton.styleFrom(
                backgroundColor: const Color(0xFF0F172A),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Filters & Controls Row (Responsive wrapping)
        LayoutBuilder(
          builder: (context, constraints) {
            return Wrap(
              spacing: 16,
              runSpacing: 16,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.spaceBetween,
              children: [
                // Time Filter Segmented Control
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                       _buildFilterChip('Morning', DashboardFilterType.morning, presenter),
                       _buildFilterChip('Night', DashboardFilterType.night, presenter),
                       _buildFilterChip('Weekly', DashboardFilterType.weekly, presenter),
                       _buildFilterChip('Monthly', DashboardFilterType.monthly, presenter),
                    ],
                  ),
                ),

                // Date Picker (Redesigned)
                // InkWell(
                //   onTap: () async {
                //     if (filter.type == DashboardFilterType.custom) {
                //        // Range Picker
                //        final picked = await showDateRangePicker(
                //           context: context,
                //           firstDate: DateTime(2020),
                //           lastDate: DateTime(2030),
                //           initialDateRange: filter.customRange,
                //        );
                //        if (picked != null) {
                //          presenter.updateCustomRange(picked);
                //        }
                //     } else {
                //        // Single Date Picker
                //        final picked = await showDatePicker(
                //         context: context,
                //         initialDate: filter.selectedDate,
                //         firstDate: DateTime(2020),
                //         lastDate: DateTime(2030),
                //       );
                //       if (picked != null) {
                //         presenter.updateDate(picked);
                //       }
                //     }
                //   },
                //   child: Container(
                //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(12),
                //       border: Border.all(color: Colors.grey.shade300),
                //     ),
                //     child: Row(
                //       mainAxisSize: MainAxisSize.min,
                //       children: [
                //         const Icon(Icons.calendar_month_outlined, size: 20, color: Color(0xFF64748B)),
                //         const SizedBox(width: 8),
                //         Text(
                //           _formatDateText(filter),
                //           style: const TextStyle(
                //             fontWeight: FontWeight.w600,
                //             color: Color(0xFF0F172A),
                //           ),
                //         ),
                //         const SizedBox(width: 8),
                //         const Icon(Icons.keyboard_arrow_down, size: 20, color: Color(0xFF64748B)),
                //       ],
                //     ),
                //   ),
                // ),
                
                // Custom Filter Button (to enable Range Picker)
                IconButton(
                  tooltip: "Custom Range",
                  onPressed: () async {
                      final picked = await showDateRangePicker(
                          context: context,
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2030),
                       );
                       if (picked != null) {
                         presenter.updateCustomRange(picked);
                       }
                  }, 
                  icon: Icon(Icons.date_range, color: filter.type == DashboardFilterType.custom ? Colors.blue : Colors.grey)
                ),
                
                // Workfile Dropdown (Hardcoded)
                Container(
                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                   decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                   ),
                   child: DropdownButtonHideUnderline(
                     child: DropdownButton<String>(
                       value: selectedWorkfile,
                       icon: const Icon(Icons.folder_open_outlined, color: Color(0xFF64748B)),
                       items: workfiles.map((String value) {
                         return DropdownMenuItem<String>(
                           value: value,
                           child: Text(
                             value,
                             style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF0F172A)),
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
            );
          }
        ),
      ],
    );
  }

  String _formatDateText(DashboardFilter filter) {
    if (filter.type == DashboardFilterType.custom && filter.customRange != null) {
      final start = DateFormat('dd MMM').format(filter.customRange!.start);
      final end = DateFormat('dd MMM').format(filter.customRange!.end);
      return "$start - $end";
    }
    return DateFormat('dd MMM yyyy').format(filter.selectedDate);
  }

  Widget _buildFilterChip(String label, DashboardFilterType type, DashboardPresenter presenter) {
    bool isSelected = presenter.filter.type == type;
    return GestureDetector(
      onTap: () => presenter.updateFilterType(type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0F172A) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF64748B),
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
