import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../dashboard_presenter.dart';
import '../../../core/utils/app_theme.dart';

class DashboardHeader extends ConsumerStatefulWidget {
  const DashboardHeader({super.key});

  @override
  ConsumerState<DashboardHeader> createState() => _DashboardHeaderState();
}

class _DashboardHeaderState extends ConsumerState<DashboardHeader> {
  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final presenter = ref.read(dashboardPresenterProvider.notifier);
    final dashboardAsync = ref.watch(dashboardPresenterProvider);
    final filter = presenter.filter;
    final workfiles = dashboardAsync.value?.workfiles ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Left: Filter tabs + custom date range
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 44,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: theme.cardSurface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: theme.cardBorderColor),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildFilterChip(theme, 'Morning',
                                  DashboardFilterType.morning, presenter),
                              _buildFilterChip(theme, 'Night',
                                  DashboardFilterType.night, presenter),
                              _buildFilterChip(theme, 'Weekly',
                                  DashboardFilterType.weekly, presenter),
                              _buildFilterChip(theme, 'Monthly',
                                  DashboardFilterType.monthly, presenter),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),

                        // Custom date range button
                        Container(
                          height: 44,
                          decoration: BoxDecoration(
                            color: theme.cardSurface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: theme.cardBorderColor),
                          ),
                          child: IconButton(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            constraints: const BoxConstraints(),
                            tooltip: "Custom Range",
                            onPressed: () async {
                              final brightness =
                                  MediaQuery.of(context).platformBrightness;
                              final isDark =
                                  brightness == Brightness.dark;
                              final picked = await showDateRangePicker(
                                context: context,
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2030),
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: isDark
                                          ? ColorScheme.dark(
                                              primary: theme.appBarAccent,
                                              onPrimary:
                                                  theme.primaryButtonText,
                                              surface: theme.pageBackground,
                                              onSurface: theme.textOnSurface,
                                            )
                                          : ColorScheme.light(
                                              primary: theme.appBarAccent,
                                              onPrimary:
                                                  theme.primaryButtonText,
                                              surface: theme.pageBackground,
                                              onSurface: theme.textOnSurface,
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
                                  ? theme.appBarAccent
                                  : theme.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(width: 16),

                    // Right: Workfile dropdown
                    Container(
                      height: 44,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: theme.cardSurface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: theme.cardBorderColor),
                      ),
                      alignment: Alignment.center,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: filter.selectedFileID,
                          dropdownColor: theme.dropdownBackground,
                          icon: Icon(
                            Icons.folder_open_outlined,
                            color: theme.textSecondary,
                            size: 20,
                          ),
                          isDense: true,
                          items: workfiles.map((workfile) {
                            final displayName =
                                workfile.areaName?.isNotEmpty == true
                                    ? workfile.areaName!
                                    : workfile.uid?.toString() ?? 'Unknown';
                            return DropdownMenuItem<String>(
                              value: workfile.uid.toString(),
                              child: Text(
                                displayName,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: theme.dropdownItemText,
                                  fontSize: 14,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            if (newValue != null) {
                              presenter.updateSelectedFileID(newValue);
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
    AppThemeData theme,
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
          color: isSelected ? theme.appBarAccent : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label.toUpperCase(),
          style: TextStyle(
            color: isSelected ? theme.primaryButtonText : theme.textSecondary,
            fontWeight: FontWeight.bold,
            fontSize: 12,
            letterSpacing: 0.8,
          ),
        ),
      ),
    );
  }
}
