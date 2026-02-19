
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
      backgroundColor: const Color(0xFFE2EFF7), // Match Light Blue background
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Reduced padding to save space
        child: Column(
          children: [
            const DashboardHeader(),
            const SizedBox(height: 12), // Reduced spacing
            Expanded(
              child: dashboardDataAsync.when(
                data: (data) => _buildDashboardContent(data),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text('Error: $err')),
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
          flex: 6, // Slightly increased flex for cards area
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
              const SizedBox(width: 12),
              
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
                              progressColor: Colors.blue,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: SummaryCard(
                              title: 'Spots Precision',
                              value: '${data.precision}',
                              subUnit: 'cm',
                              subValue: '10 cm',
                              percent: data.percentagePrecision,
                              progressColor: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
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
                              progressColor: Colors.green,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: SummaryCard(
                              title: 'Work Hours',
                              value: data.workHours,
                              subUnit: 'hours',
                              subValue: '12 Hours',
                              percent: data.percentageWorkHours,
                              progressColor: Colors.purple,
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
        
        const SizedBox(height: 12),
        
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
                  lineColor: Colors.blue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TrendChart(
                  title: 'Production Trend',
                  unit: 'Spot',
                  spots: data.productionTrend,
                  maxY: data.productionMaxY,
                  interval: data.trendInterval,
                  lineColor: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
