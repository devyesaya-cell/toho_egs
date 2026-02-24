import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dashboard_presenter.dart';
import 'widgets/dashboard_header.dart';
import 'widgets/progress_card.dart';
import 'widgets/summary_card.dart';
import 'widgets/trend_chart.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardDataAsync = ref.watch(dashboardPresenterProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0F1410), // Dark background
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const DashboardHeader(),
            const SizedBox(height: 16),
            Expanded(
              child: dashboardDataAsync.when(
                data: (data) => _buildDashboardContent(data),
                loading: () => const Center(
                  child: CircularProgressIndicator(color: Color(0xFF2ECC71)),
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

  Widget _buildDashboardContent(DashboardData data) {
    return Column(
      children: [
        // Top Row: Big Progress Card + Grid of Summary Cards
        Expanded(
          flex: 6,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left: Progress Card
              Expanded(
                flex: 4,
                child: ProgressCard(
                  areaHa: data.areaHa,
                  maxAreaHa: data.maxAreaHa,
                  percentage: data.percentageProgress,
                  totalSpots: data.productionSpots,
                ),
              ),
              const SizedBox(width: 16),

              // Right: Grid of 4 cards
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
                              value: '${data.productivity}',
                              subUnit: 'spots/hr',
                              subValue: '${data.productivitySpotsHr} spots/Hr',
                              percent: data.percentageProductivity,
                              progressColor: const Color(0xFF3B82F6), // Blue
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: SummaryCard(
                              title: 'Spots Precision',
                              value: '${data.precision}',
                              subUnit: 'cm',
                              subValue: '10 cm',
                              percent: data.percentagePrecision,
                              progressColor: const Color(0xFFEF4444), // Red
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
                              value: '${data.productionSpots}',
                              subUnit: 'spot',
                              subValue: '${data.productionSpotsTotal} spots',
                              percent: data.percentageProduction,
                              progressColor: const Color(
                                0xFF2ECC71,
                              ), // Primary Green
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
                              progressColor: const Color(0xFFA855F7), // Purple
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

        // Bottom Row: 2 Charts
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
                  lineColor: const Color(0xFF3B82F6), // Blue
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TrendChart(
                  title: 'Production Trend',
                  unit: 'Spot',
                  spots: data.productionTrend,
                  maxY: data.productionMaxY,
                  interval: data.trendInterval,
                  lineColor: const Color(0xFF2ECC71), // Primary Green
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
