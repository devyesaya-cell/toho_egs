
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProgressCard extends StatelessWidget {
  final double areaHa;
  final double maxAreaHa;
  final double percentage;
  final int totalSpots;

  const ProgressCard({
    super.key,
    this.areaHa = 0,
    this.maxAreaHa = 5,
    this.percentage = 0,
    this.totalSpots = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9), 
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
           colors: [Color(0xFFF3E8FF), Color(0xFFF1F5F9)], 
           begin: Alignment.topLeft,
           end: Alignment.bottomRight,
        ),
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
                      "${(percentage * 100).toStringAsFixed(1)}% /",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF334155)),
                    ),
                    Text(
                      "$maxAreaHa ha",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF334155)),
                    ),
                  ],
                ),
                progressColor: const Color(0xFFB91C1C), 
                backgroundColor: const Color(0xFFCBD5E1),
                circularStrokeCap: CircularStrokeCap.round,
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Area',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    areaHa.toString(),
                    style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
                  ),
                   const Text(
                    'Ha',
                    style: TextStyle(fontSize: 14, color: Color(0xFF94A3B8)),
                  ),
                  const SizedBox(height: 4),
                   Text(
                    totalSpots.toString(),
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                   const Text(
                    'spots',
                    style: TextStyle(fontSize: 10, color: Color(0xFF94A3B8)),
                  ),
                ],
              )
            ],
          ),
          const Spacer(),
          const Text(
            'Working Progress',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B), 
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Spacing: 4.0 m x 1.87 m',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF1E293B),
              fontWeight: FontWeight.w500
            ),
          ),
          Text(
            'Luas Area : $maxAreaHa Ha',
             style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF1E293B),
              fontWeight: FontWeight.w500
            ),
          ),
        ],
      ),
    );
  }
}
