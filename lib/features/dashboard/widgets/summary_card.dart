import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final String subUnit; // 'spots/hr', 'cm', 'hours'
  final String? subValue; // e.g. '187.17 spots/Hr'
  final double percent;
  final Color progressColor;
  final bool isTrendUp;

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
        color: const Color(0xFF0F1410),
        border: Border.all(color: const Color(0xFF1E3A2A), width: 1.5),
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
                      const Icon(
                        Icons.bar_chart,
                        size: 14,
                        color: Color(0xFFB0BEC5),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        subValue!,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFFB0BEC5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
                Text(
                  title.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 10,
                    letterSpacing: 1.1,
                    color: Color(0xFFB0BEC5),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      subUnit,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF2ECC71),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
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
                color: Colors.white,
              ),
            ),
            progressColor: progressColor,
            backgroundColor: const Color(0xFF1E293B),
            circularStrokeCap: CircularStrokeCap.round,
          ),
        ],
      ),
    );
  }
}
