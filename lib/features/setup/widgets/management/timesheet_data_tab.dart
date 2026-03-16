import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/repositories/app_repository.dart';
import '../../../../core/models/timesheet_data.dart';
import '../../../../core/utils/app_theme.dart';
import 'timesheet_data_edit_dialog.dart';

class TimesheetDataTab extends ConsumerWidget {
  const TimesheetDataTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stream = ref.watch(appRepositoryProvider).watchTimesheetDatas();

    return StreamBuilder<List<TimesheetData>>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF2ECC71)),
          );
        }
        final items = snapshot.data ?? [];

        return LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            int crossAxisCount = 2;
            if (width > 700) crossAxisCount = 3;
            if (width > 1000) crossAxisCount = 4;
            if (width > 1400) crossAxisCount = 5;

            double totalSpacing = (crossAxisCount - 1) * 16 + 32;
            double itemWidth = (width - totalSpacing) / crossAxisCount;
            // The item height for AreaCardWidget is around 230, let's use 160 here for TimesheetData as it has less fields
            double childAspectRatio = itemWidth / 170;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => _showEditDialog(context, null),
                        icon: const Icon(Icons.add),
                        label: const Text('ADD TIMESHEET DATA'),
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
                if (items.isEmpty)
                  Expanded(
                    child: Center(
                      child: Builder(builder: (ctx) {
                        final theme = AppTheme.of(ctx);
                        return Text(
                          'No Timesheet Data found.',
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
                      itemCount: items.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: childAspectRatio,
                      ),
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return _buildCard(context, ref, item);
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

  Widget _buildCard(BuildContext context, WidgetRef ref, TimesheetData data) {
    final theme = AppTheme.of(context);
    IconData displayIcon = Icons.build;
    if (data.icon == 'local_gas_station') displayIcon = Icons.local_gas_station;
    if (data.icon == 'precision_manufacturing')
      displayIcon = Icons.precision_manufacturing;

    return Card(
      color: theme.cardSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.cardBorderColor),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Icon + Title
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.pageBackground,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: theme.cardBorderColor),
                  ),
                  child: Icon(
                    displayIcon,
                    color: theme.iconBoxIcon,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.activityName ?? 'Unknown',
                        style: TextStyle(
                          color: theme.textOnSurface,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        data.activityType ?? 'Unknown Type',
                        style: TextStyle(
                          color: theme.appBarAccent,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            Divider(color: theme.dividerColor),
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => _showEditDialog(context, data),
                  icon: const Icon(
                    Icons.edit_outlined,
                    color: Colors.blueAccent, // semantic — stays blue
                  ),
                  tooltip: 'Edit',
                ),
                IconButton(
                  onPressed: () => _confirmDelete(context, ref, data),
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Color(0xFFEF4444), // semantic — stays red
                  ),
                  tooltip: 'Delete',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, TimesheetData? data) {
    showDialog(
      context: context,
      builder: (context) => TimesheetDataEditDialog(timesheetData: data),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, TimesheetData data) {
    showDialog(
      context: context,
      builder: (ctx) {
        final theme = AppTheme.of(ctx);
        return AlertDialog(
          backgroundColor: theme.dialogBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: theme.cardBorderColor),
          ),
          title: Text('Delete Timesheet Data',
              style: TextStyle(color: theme.textOnSurface)),
          content: Text(
            'Are you sure you want to delete "${data.activityName}"?',
            style: TextStyle(color: theme.textSecondary),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text('Cancel',
                  style: TextStyle(color: theme.textSecondary)),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(appRepositoryProvider).deleteTimesheetData(data.id);
                Navigator.pop(ctx);
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
