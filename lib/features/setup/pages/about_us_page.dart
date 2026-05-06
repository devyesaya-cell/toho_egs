import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/app_theme.dart';
import '../../../core/widgets/global_app_bar_actions.dart';
import '../../../core/models/workfile.dart';
import '../presenter/about_us_presenter.dart';

class AboutUsPage extends ConsumerWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = AppTheme.of(context);
    final state = ref.watch(aboutUsProvider);
    final notifier = ref.read(aboutUsProvider.notifier);

    // Show snackbar listener for success/error
    ref.listen<AboutUsState>(aboutUsProvider, (previous, next) {
      if (next.statusMessage != null && next.statusMessage != previous?.statusMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.statusMessage!),
            backgroundColor: next.isSuccess ? Colors.green : Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    });

    return Scaffold(
      backgroundColor: theme.pageBackground,
      appBar: AppBar(
        title: Text('Export GeoJSON', style: TextStyle(color: theme.appBarForeground)),
        backgroundColor: theme.appBarBackground,
        iconTheme: IconThemeData(color: theme.appBarForeground),
        actions: const [GlobalAppBarActions()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Export Workingspot',
              style: TextStyle(
                color: theme.textOnSurface,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Pilih Workfile untuk mengekspor data Workingspot yang sudah diselesaikan (status=1) ke format GeoJSON. File akan disimpan di folder Download perangkat.',
              style: TextStyle(color: theme.textOnSurface.withOpacity(0.7), fontSize: 16),
            ),
            const SizedBox(height: 32),
            Text(
              'Pilih Workfile',
              style: TextStyle(
                color: theme.textOnSurface,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: theme.surfaceColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: theme.appBarBackground),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<WorkFile>(
                  isExpanded: true,
                  dropdownColor: theme.surfaceColor,
                  value: state.selectedWorkfile,
                  hint: Text('Pilih Workfile', style: TextStyle(color: theme.textOnSurface.withOpacity(0.5))),
                  items: state.workfiles.map((wf) {
                    return DropdownMenuItem<WorkFile>(
                      value: wf,
                      child: Text(
                        wf.areaName ?? 'Unknown Area',
                        style: TextStyle(color: theme.textOnSurface),
                      ),
                    );
                  }).toList(),
                  onChanged: (val) {
                    notifier.selectWorkfile(val);
                  },
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.appBarBackground,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: state.isLoading || state.selectedWorkfile == null
                    ? null
                    : () {
                        notifier.exportGeoJson();
                      },
                child: state.isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      )
                    : const Text(
                        'Download GeoJSON',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
