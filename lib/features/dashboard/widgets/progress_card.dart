import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../core/utils/app_theme.dart';

class ProgressCard extends StatelessWidget {
  final double areaHa;
  final double maxAreaHa;
  final double percentage;
  final double totalSpots;
  final String spacing;
  final String productionUnit;

  const ProgressCard({
    super.key,
    this.areaHa = 0,
    this.maxAreaHa = 5,
    this.percentage = 0,
    this.totalSpots = 0.0,
    this.spacing = '4.0 m x 1.87 m',
    this.productionUnit = 'm²',
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.pageBackground,
        border: Border.all(color: theme.cardBorderColor, width: 1.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircularPercentIndicator(
                radius: 45.0,
                lineWidth: 10.0,
                percent: percentage,
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${(percentage * 100).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: theme.textOnSurface,
                      ),
                    ),
                    Text(
                      "/ ${maxAreaHa.toStringAsFixed(3)} ha",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        color: theme.textSecondary,
                      ),
                    ),
                  ],
                ),
                progressColor: theme.appBarAccent, // themed accent color
                backgroundColor: theme.cardSurface,
                circularStrokeCap: CircularStrokeCap.round,
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TOTAL AREA',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                      color: theme.textSecondary,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        areaHa.toStringAsFixed(3),
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          color: theme.textOnSurface,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6.0, left: 4.0),
                        child: Text(
                          'Ha',
                          style: TextStyle(
                            fontSize: 14,
                            color: theme.appBarAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        totalSpots.toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: theme.textOnSurface,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        productionUnit,
                        style: TextStyle(
                          fontSize: 10,
                          color: theme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Divider(color: theme.cardBorderColor),
          const SizedBox(height: 8),
          Text(
            'WORKING PROGRESS',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
              color: theme.textOnSurface,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Spacing',
                  style: TextStyle(fontSize: 12, color: theme.textSecondary)),
              Text(
                spacing,
                style: TextStyle(
                    fontSize: 12,
                    color: theme.textOnSurface,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Luas Area',
                  style: TextStyle(fontSize: 12, color: theme.textSecondary)),
              Text(
                '${maxAreaHa.toStringAsFixed(3)} Ha',
                style: TextStyle(
                    fontSize: 12,
                    color: theme.textOnSurface,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
