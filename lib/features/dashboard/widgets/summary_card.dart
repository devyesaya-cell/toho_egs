import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../core/utils/app_theme.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final String subUnit;
  final String? subValue;
  final double percent;
  final Color progressColor; // semantic — fixed per metric (blue/red/green/purple)
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
    final theme = AppTheme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.pageBackground,
        border: Border.all(color: theme.cardBorderColor, width: 1.5),
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
                      Icon(Icons.bar_chart, size: 14, color: theme.textSecondary),
                      const SizedBox(width: 4),
                      Text(
                        subValue!,
                        style: TextStyle(
                          fontSize: 10,
                          color: theme.textSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
                Text(
                  title.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    letterSpacing: 1.1,
                    color: theme.textSecondary,
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
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: theme.textOnSurface,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      subUnit,
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.appBarAccent,
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
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: theme.textOnSurface,
              ),
            ),
            progressColor: progressColor, // metric-specific — semantic, stays fixed
            backgroundColor: theme.cardSurface,
            circularStrokeCap: CircularStrokeCap.round,
          ),
        ],
      ),
    );
  }
}
