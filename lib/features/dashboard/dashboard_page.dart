import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dashboard_presenter.dart';
import 'widgets/dashboard_header.dart';
import 'widgets/progress_card.dart';
import 'widgets/summary_card.dart';
import 'widgets/trend_chart.dart';
import '../../core/widgets/global_app_bar_actions.dart';
import '../../core/state/auth_state.dart';
import '../../core/utils/app_theme.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = AppTheme.of(context);
    final dashboardDataAsync = ref.watch(dashboardPresenterProvider);
    final auth = ref.watch(authProvider);
    final systemMode = auth.mode.stableName;
    final isCrumbling = systemMode == 'CRUMBLING';

    return Scaffold(
      backgroundColor: theme.pageBackground,
      appBar: AppBar(
        backgroundColor: theme.appBarBackground,
        foregroundColor: theme.appBarForeground,
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: theme.iconBoxBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.dashboard, color: theme.iconBoxIcon, size: 24),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'EGS DASHBOARD',
                  style: TextStyle(
                    color: theme.appBarForeground,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'SYSTEM MODE: $systemMode',
                  style: TextStyle(
                    color: theme.appBarAccent,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: const [GlobalAppBarActions(), SizedBox(width: 16)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const DashboardHeader(),
            const SizedBox(height: 16),
            Expanded(
              child: dashboardDataAsync.when(
                data: (data) =>
                    _buildDashboardContent(data, isCrumbling),
                loading: () => Center(
                  child: CircularProgressIndicator(
                      color: theme.loadingIndicatorColor),
                ),
                error: (err, stack) => Center(
                  child: Text(
                    'Error: $err',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardContent(DashboardData data, bool isCrumbling) {
    return Column(
      children: [
        Expanded(
          flex: 6,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 4,
                child: ProgressCard(
                  areaHa: data.areaHa,
                  maxAreaHa: data.maxAreaHa,
                  percentage: data.percentageProgress,
                  totalSpots: data.productionSpots,
                  spacing: data.spacing,
                  productionUnit: isCrumbling ? 'm²' : 'spot',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 7,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: SummaryCard(
                              title: 'Productivity',
                              value: data.productivity.toStringAsFixed(0),
                              subUnit: isCrumbling ? 'm²/hr' : 'spots/hr',
                              subValue: isCrumbling
                                  ? ''
                                  : '${data.productivitySpotsHr.toStringAsFixed(0)} spots/Hr',
                              percent: data.percentageProductivity,
                              progressColor:
                                  const Color(0xFF3B82F6), // semantic blue
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: SummaryCard(
                              title: isCrumbling
                                  ? 'Line Precision'
                                  : 'Spots Precision',
                              value: '${data.precision}',
                              subUnit: 'cm',
                              subValue: '10 cm',
                              percent: data.percentagePrecision,
                              progressColor:
                                  const Color(0xFFEF4444), // semantic red
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: SummaryCard(
                              title: 'Production',
                              value: data.productionSpots.toStringAsFixed(1),
                              subUnit: isCrumbling ? 'm²' : 'spot',
                              subValue: isCrumbling
                                  ? ''
                                  : '${data.productionSpotsTotal.toStringAsFixed(0)} spots',
                              percent: data.percentageProduction,
                              progressColor:
                                  const Color(0xFF2ECC71), // semantic green
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: SummaryCard(
                              title: 'Work Hours',
                              value: data.workHours,
                              subUnit: 'hours',
                              subValue: '12 Hours',
                              percent: data.percentageWorkHours,
                              progressColor:
                                  const Color(0xFFA855F7), // semantic purple
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          flex: 4,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: TrendChart(
                  title: 'Productivity Trend',
                  unit: 'Ha',
                  spots: data.productivityTrend,
                  maxY: data.productivityMaxY,
                  interval: data.trendInterval,
                  lineColor: const Color(0xFF3B82F6),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TrendChart(
                  title: 'Production Trend',
                  unit: isCrumbling ? 'm²' : 'Spot',
                  spots: data.productionTrend,
                  maxY: data.productionMaxY,
                  interval: data.trendInterval,
                  lineColor: const Color(0xFF2ECC71),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
