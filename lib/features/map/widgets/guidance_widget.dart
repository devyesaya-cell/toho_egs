import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../map_presenter.dart';

class GuidanceWidget extends ConsumerWidget {
  const GuidanceWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapState = ref.watch(mapPresenterProvider);

    // Deviation Calculation
    final devX = mapState.devX ?? 0.0;
    final devY = mapState.devY ?? 0.0;

    // Helper: Each bar represents 10cm up to 40cm+
    int getActiveBars(double dev) {
      if (dev < 0.1) return 0;
      return (dev / 0.1).floor().clamp(0, 4);
    }

    final int rightActive = getActiveBars(devX);
    final int leftActive = getActiveBars(-devX);
    final int topActive = getActiveBars(devY); // Forward
    final int bottomActive = getActiveBars(-devY); // Backward

    // 1. Get Screen Size
    final screenSize = MediaQuery.of(context).size;

    // 2. Calculate Widget Size (50% of screen height)
    final widgetSize = screenSize.height * 0.5;

    // 3. Calculate Scale Factor based on reference 300px
    final double scale = widgetSize / 300.0;

    // 4. Center Anchoring Logic
    final double centerXY = widgetSize / 2;
    // Gap from center: Circle radius is ~20*scale. Clear zone ~30*scale.
    final double centerGap = 19.0 * scale;

    // Center icon logic: If both devX and devY are within a small threshold (e.g. 10cm), it's "Locked"
    final bool isCenterLocked =
        mapState.targetSpot != null && devX.abs() < 0.1 && devY.abs() < 0.1;

    return SizedBox(
      width: widgetSize,
      height: widgetSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background
          Image.asset(
            'images/target_bg.png',
            width: widgetSize,
            height: widgetSize,
            fit: BoxFit.contain,
          ),

          // Center Target
          Image.asset(
            isCenterLocked
                ? 'images/ic_cirle_tg.png'
                : 'images/ic_cirle.png', // Assuming there's a lit version, or we can tint it. We will use ColorFiltered if no lit image.
            width: 40 * scale,
            height: 40 * scale,
            color: isCenterLocked
                ? Colors.greenAccent
                : null, // Tint green if locked
          ),

          // Right Bars (Pointing Left) - East
          // Starts from Center + Gap, grows Right.
          Positioned(
            left: centerXY + centerGap,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                4,
                (index) => _buildBar(
                  'images/right_tg.png',
                  'images/right_no_tg.png',
                  index < rightActive,
                  width: 25 * scale,
                  height: 40 * scale,
                  padding: 2.0 * scale,
                ),
              ), // Inner -> Outer
            ),
          ),

          // Left Bars (Pointing Right) - West
          // Ends at Center - Gap.
          Positioned(
            right: centerXY + centerGap,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                4,
                (index) => _buildBar(
                  'images/left_tg.png',
                  'images/left_no_tg.png',
                  index < leftActive,
                  width: 25 * scale,
                  height: 40 * scale,
                  padding: 2.0 * scale,
                ),
              ).reversed.toList(), // Outer -> Inner
            ),
          ),

          // Bottom Bars (Pointing Up) - South
          // Starts from Center + Gap, grows Down.
          Positioned(
            top: centerXY + centerGap,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                4,
                (index) => _buildBar(
                  'images/down_tg.png',
                  'images/down_no_tg.png',
                  index < bottomActive,
                  width: 40 * scale,
                  height: 25 * scale,
                  padding: 2.0 * scale,
                ),
              ), // Inner -> Outer
            ),
          ),

          // Top Bars (Pointing Down) - North
          // Ends at Center - Gap.
          Positioned(
            bottom: centerXY + centerGap,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                4,
                (index) => _buildBar(
                  'images/top_tg.png',
                  'images/top_no_tg.png',
                  index < topActive,
                  width: 40 * scale,
                  height: 25 * scale,
                  padding: 2.0 * scale,
                ),
              ).reversed.toList(), // Outer -> Inner
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar(
    String activePath,
    String inactivePath,
    bool isActive, {
    double width = 20,
    double height = 20,
    double padding = 2.0,
  }) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Image.asset(
        isActive ? activePath : inactivePath,
        width: width,
        height: height,
        fit: BoxFit.contain,
      ),
    );
  }
}
