import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TrendChart extends StatelessWidget {
  final String title;
  final String unit; // 'Ha' or 'Spot'
  final List<FlSpot> spots;
  final double maxY;
  final Color lineColor;
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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1410),
        border: Border.all(color: const Color(0xFF1E3A2A), width: 1.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                unit == 'Ha' ? '0.0 Ha' : '0 Spot',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFB0BEC5),
                ),
              ),
              Text(
                title.toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  letterSpacing: 1.1,
                  color: Colors.white,
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
                      color: const Color(0xFF1E3A2A),
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
                            // 1 day in milliseconds
                            text = DateFormat('dd/MM').format(dt);
                          } else {
                            text = DateFormat('HH:mm').format(dt);
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              text,
                              style: const TextStyle(
                                fontSize: 10,
                                color: Color(0xFFB0BEC5),
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
                  border: const Border(
                    bottom: BorderSide(color: Color(0xFF1E3A2A), width: 1),
                  ),
                ),
                minY: 0,
                maxY: maxY,
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: lineColor,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: lineColor.withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(
            unit == 'Ha' ? '0.11 Ha' : '11 Spot', // Mock Y-Axis max label
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Color(0xFFB0BEC5),
            ),
          ),
        ],
      ),
    );
  }
}
