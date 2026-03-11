import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../map_presenter.dart';

class CrumblingDeviationBar extends ConsumerWidget {
  const CrumblingDeviationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapState = ref.watch(mapPresenterProvider);
    final deviation = mapState.crumblingDeviation;

    final size = MediaQuery.of(context).size;
    final barWidth = size.width * 0.45; // slightly wider for 11 bars
    final barHeight = size.height * 0.15;

    // Deviation index (from -5 to +5)
    // 0 is center (-10 to 10cm)
    int activeIndex = 5; // Default center (index 5)

    final displayDev = deviation ?? 0.0;

    // Determine active index
    if (deviation == null || (displayDev >= -10 && displayDev <= 10)) {
      activeIndex = 5;
    } else {
      if (displayDev < -10) {
        int steps = ((displayDev + 10).abs() / 10).ceil();
        activeIndex = 5 - steps;
        if (activeIndex < 0) activeIndex = 0; // cap at far left
      } else {
        int steps = ((displayDev - 10) / 10).ceil();
        activeIndex = 5 + steps;
        if (activeIndex > 10) activeIndex = 10; // cap at far right
      }
    }

    return Container(
      width: barWidth,
      height: barHeight,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1E241E).withOpacity(0.95), // Dark greenish black
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.withOpacity(0.3), width: 1),
        boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 8)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(11, (index) {
                if (index == 5) {
                  // Center block is always prominently green as reference
                  return _buildCenterBarItem(
                    Colors.greenAccent,
                    activeIndex == 5,
                  );
                }

                final isLit = index == activeIndex;
                Color litColor = Colors.redAccent;
                if (isLit) {
                  if ((index - 5).abs() >= 3) {
                    litColor = Colors.redAccent;
                  } else {
                    litColor = Colors.orangeAccent;
                  }
                }

                return _buildBarItem(
                  isLit ? litColor : Colors.green.withOpacity(0.1),
                  isLit,
                );
              }),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'L',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white54,
                ),
              ),
              Text(
                deviation == null
                    ? '-- cm'
                    : '${displayDev.abs().toStringAsFixed(1)} cm',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: activeIndex == 5
                      ? Colors.greenAccent
                      : Colors.redAccent,
                ),
              ),
              const Text(
                'R',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBarItem(Color color, bool isLit) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        height: 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(2),
          boxShadow: isLit
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.6),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
      ),
    );
  }

  Widget _buildCenterBarItem(Color color, bool isLit) {
    return Expanded(
      flex: 3,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        height: 50,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
          boxShadow: isLit
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.8),
                    blurRadius: 12,
                    spreadRadius: 3,
                  ),
                ]
              : [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ], // Always have a slight glow on the center
        ),
      ),
    );
  }
}
