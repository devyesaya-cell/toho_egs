import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/utils/app_theme.dart';

class TrendChart extends StatelessWidget {
  final String title;
  final String unit;
  final List<FlSpot> spots;
  final double maxY;
  final Color lineColor; // semantic — stays fixed per chart
  final double interval;

  const TrendChart({
    super.key,
    required this.title,
    required this.unit,
    required this.spots,
    required this.maxY,
    this.lineColor = const Color(0xFF2ECC71),
    this.interval = 7200000,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.pageBackground,
        border: Border.all(color: theme.cardBorderColor, width: 1.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                unit == 'Ha' ? '0.0 Ha' : '0 $unit',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: theme.textSecondary,
                ),
              ),
              Text(
                title.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  letterSpacing: 1.1,
                  color: theme.textOnSurface,
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),

          const SizedBox(height: 16),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: theme.cardBorderColor,
                      strokeWidth: 1,
                      dashArray: [4, 4],
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value > 1000000000000) {
                          final dt = DateTime.fromMillisecondsSinceEpoch(
                            value.toInt(),
                          );
                          String text;
                          if (interval >= 86400000) {
                            text = DateFormat('dd/MM').format(dt);
                          } else {
                            text = DateFormat('HH:mm').format(dt);
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              text,
                              style: TextStyle(
                                fontSize: 10,
                                color: theme.textSecondary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }
                        return const Text('');
                      },
                      interval: interval,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border(
                    bottom: BorderSide(color: theme.cardBorderColor, width: 1),
                  ),
                ),
                minY: 0,
                maxY: maxY,
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: lineColor, // semantic — stays fixed
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: lineColor.withValues(alpha: 0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(
            unit == 'Ha'
                ? '${maxY.toStringAsFixed(2)} Ha'
                : '${maxY.toStringAsFixed(0)} $unit',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: theme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
