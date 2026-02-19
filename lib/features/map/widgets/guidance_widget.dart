import 'package:flutter/material.dart';

class GuidanceWidget extends StatelessWidget {
  const GuidanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
            'images/ic_cirle.png',
            width: 40 * scale,
            height: 40 * scale,
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
                  false,
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
                  false,
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
                  false,
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
                  false,
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
