
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final String subUnit; // 'spots/hr', 'cm', 'hours'
  final String? subValue; // e.g. '187.17 spots/Hr' - displayed in top left small
  final double percent;
  final Color progressColor;
  final bool isTrendUp; // Add icon if needed later

  const SummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.subUnit,
    this.subValue,
    required this.percent,
    required this.progressColor,
    this.isTrendUp = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (subValue != null) ...[
                  Row(
                     children: [
                       const Icon(Icons.bar_chart, size: 14, color: Colors.grey),
                       const SizedBox(width: 4),
                       Text(
                        subValue!,
                        style: const TextStyle(
                          fontSize: 10, 
                          color: Color(0xFF64748B), 
                          fontWeight: FontWeight.bold
                        ),
                       ),
                     ],
                  ),
                  const SizedBox(height: 4),
                ],
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF1E293B),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                 Text(
                  subUnit,
                  style: TextStyle(
                    fontSize: 12,
                    color: const Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ),
          CircularPercentIndicator(
            radius: 35.0,
            lineWidth: 8.0,
            percent: percent,
            center: Text(
              "${(percent * 100).toStringAsFixed(1)}%",
              style: const TextStyle(
                fontWeight: FontWeight.bold, 
                fontSize: 12,
                color: Color(0xFF475569),
              ),
            ),
            progressColor: progressColor,
            backgroundColor: const Color(0xFFF1F5F9),
            circularStrokeCap: CircularStrokeCap.round,
          ),
        ],
      ),
    );
  }
}
