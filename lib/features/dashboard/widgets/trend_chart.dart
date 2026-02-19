
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TrendChart extends StatelessWidget {
// ... existing constructor ...
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
    this.lineColor = Colors.blue,
    this.interval = 7200000,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
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
                 style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF64748B))
              ),
               Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(width: 20), // Balance spacing
            ],
          ),
      
          const SizedBox(height: 16),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                         if (value > 1000000000000) {
                           final dt = DateTime.fromMillisecondsSinceEpoch(value.toInt());
                           String text;
                           if (interval >= 86400000) { // 1 day in milliseconds
                             text = DateFormat('dd/MM').format(dt);
                           } else {
                             text = DateFormat('HH:mm').format(dt);
                           }
                           return Padding(
                             padding: const EdgeInsets.only(top: 8.0),
                             child: Text(
                               text,
                               style: const TextStyle(fontSize: 10, color: Color(0xFF64748B)),
                             ),
                           );
                         }
                         return const Text('');
                      },
                      interval: interval, 
                    ),
                  ),
                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: const Border(bottom: BorderSide(color: Color(0xFFCBD5E1), width: 1)),
                ),
                // minX/maxX removed to allow auto-scaling
                minY: 0,
                maxY: maxY,
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: lineColor,
                    barWidth: 2,
                    isStrokeCapRound: true,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
              ),
            ),
          ),
          Text(
             unit == 'Ha' ? '0.11 Ha' : '11 Spot', // Mock Y-Axis min label
             style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF64748B))
          ),
        ],
      ),
    );
  }
}
