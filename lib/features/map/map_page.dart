import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maplibre/maplibre.dart';
import 'map_presenter.dart';
import 'widgets/guidance_widget.dart';
import 'widgets/map_info_panel.dart';
import 'widgets/timesheet_start_dialog.dart';
import 'widgets/timesheet_end_dialog.dart';
import 'widgets/crumbling_deviation_bar.dart';
import '../../core/state/auth_state.dart';
import '../../core/utils/dialog_utils.dart';

class MapPage extends ConsumerStatefulWidget {
  const MapPage({super.key});

  @override
  ConsumerState<MapPage> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  static const double _defaultZoom = 14.0;
  bool _showMenu = false;
  MapController? _controller;
  // Using a public demo style for initialization
  // final String _styleString = 'https://demotiles.maplibre.org/style.json';

  bool _hasInitialCenter = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final mapState = ref.read(mapPresenterProvider);
      if (mapState.activeTimesheet == null) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => const TimesheetStartDialog(),
        );
      }
    });
  }

  void _toZoom(double zoom, double lon, double lat) async {
    if (_controller == null) return;
    _controller?.moveCamera(
      zoom: zoom,
      center: Geographic(lon: lon, lat: lat),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Map State
    final mapState = ref.watch(mapPresenterProvider);
    final authState = ref.watch(authProvider);
    final isCrumblingMode = authState.mode.name.toUpperCase() == 'CRUMBLING';
    final size = MediaQuery.of(context).size;

    // Listen for Location Updates to move camera & Update Excavator
    ref.listen(mapPresenterProvider, (previous, next) {
      if (next.currentLat != null &&
          next.currentLng != null &&
          _controller != null) {
        // Auto Center Logic
        // 1. Always center if in Work Mode
        // 2. Only center once initially if in Standby Mode
        if (next.isWorkMode || !_hasInitialCenter) {
          _controller?.moveCamera(
            center: Geographic(lon: next.currentLng!, lat: next.currentLat!),
            bearing: next.targetBearing ?? next.heading,
          );
          if (!_hasInitialCenter) {
            _hasInitialCenter = true;
          }
        }

        // Update Excavator Position
        if (next.fullGps != null) {
          ref
              .read(mapPresenterProvider.notifier)
              .updateExcavatorPosition(_controller!, next.fullGps!);
        }
      }

      // Auto-reload Spots if spotDone counter increases (meaning a spot was auto-completed)
      if (previous != null &&
          next.spotDone > previous.spotDone &&
          _controller != null) {
        ref.read(mapPresenterProvider.notifier).loadSpots(_controller!);
      }

      // Show notification if diggingStatus becomes true
      if (previous != null && !previous.diggingStatus && next.diggingStatus) {
        ref
            .read(mapPresenterProvider.notifier)
            .showDiggingNotification(context);
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          // ===== MAP =====
          // Use AbsorbPointer to lock map gestures in Work Mode
          AbsorbPointer(
            absorbing: mapState.isWorkMode,
            child: MapLibreMap(
              onMapCreated: (controller) {
                _controller = controller;
              },
              onStyleLoaded: (_) {
                // Initialize Excavator Layers once style is loaded
                if (_controller != null) {
                  ref
                      .read(mapPresenterProvider.notifier)
                      .addExcavatorLayers(_controller!);
                }
              },
              options: const MapOptions(
                // styleString: _styleString,
                initCenter: Geographic(lon: 106.8456, lat: -6.2088),
                initZoom: _defaultZoom,
                initBearing: 0,
              ),
            ),
          ),

          // ===== TOP MENU BUTTON =====
          Positioned(
            top: size.height * 0.05,
            left: size.width * 0.02,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E241E).withOpacity(0.9),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.withOpacity(0.5)),
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 4),
                ],
              ),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _showMenu = !_showMenu;
                  });
                },
                icon: const Icon(Icons.menu_rounded, color: Colors.greenAccent),
                tooltip: 'Menu',
              ),
            ),
          ),

          // ===== ZOOM & MENU BUTTONS =====
          if (_showMenu)
            Positioned(
              right: size.width * 0.02,
              bottom: size.height * 0.12,
              child: Column(
                children: [
                  // Zoom In
                  _buildFloatingButton(
                    icon: Icons.zoom_in,
                    onPressed: () {
                      // Increment Zoom
                      // Note: MapLibre controller might not allow getting current zoom easily without async
                      // For test just zoom to fixed levels or use controller methods if available
                      if (_controller != null) {
                        // _controller?.moveCamera(zoom: 16);
                        // Better:
                        // _controller?.easeCamera(CameraUpdate.zoomIn()); ??
                        // Reference used explicit moveCamera.
                        // Let's just mock zoom in
                        _toZoom(
                          21.2,
                          mapState.currentLng!,
                          mapState.currentLat!,
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  // Zoom Out
                  _buildFloatingButton(
                    icon: Icons.zoom_out,
                    onPressed: () {
                      _toZoom(19.0, mapState.currentLng!, mapState.currentLat!);
                    },
                  ),
                  const SizedBox(height: 10),
                  // Work Mode Toggle
                  _buildFloatingButton(
                    icon: mapState.isWorkMode ? Icons.stop : Icons.play_arrow,
                    color: mapState.isWorkMode ? Colors.red : Colors.green,
                    onPressed: () {
                      ref
                          .read(mapPresenterProvider.notifier)
                          .toggleWorkMode(_controller);
                    },
                  ),
                  const SizedBox(height: 10),
                  // Settings
                  _buildFloatingButton(
                    icon: Icons.settings,
                    color: Colors.amber,
                    onPressed: () {
                      final currentDelay = ref.read(mapPresenterProvider).spotCompletionDelay;
                      DialogUtils.showDelayConfigDialog(
                        context: context,
                        currentDelay: currentDelay,
                        onSave: (val) {
                          ref.read(mapPresenterProvider.notifier).setSpotCompletionDelay(val);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),

          // ===== GUIDANCE WIDGET =====
          if (mapState.isWorkMode && !isCrumblingMode)
            Positioned(
              right: size.width * 0.01,
              top: size.height * 0.09,
              child: const GuidanceWidget(),
            ),

          // ===== CRUMBLING DEVIATION BAR =====
          if (mapState.isWorkMode && isCrumblingMode)
            Positioned(
              top: size.height * 0.05,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.topCenter,
                child: const CrumblingDeviationBar(),
              ),
            ),

          // ===== TOP RIGHT CONNECTION STATUS & EXIT =====
          Positioned(
            top: size.height * 0.05,
            right: size.width * 0.02,
            child: Row(
              children: [
                // Status Box
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E241E).withOpacity(0.9),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green.withOpacity(0.5)),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 4),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Conn: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.circle,
                        color: mapState.usbConnected
                            ? Colors.greenAccent
                            : Colors.redAccent,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        mapState.usbConnected ? 'Connected' : 'Disconnected',
                        style: TextStyle(
                          color: mapState.usbConnected
                              ? Colors.greenAccent
                              : Colors.redAccent,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                // Exit Button
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E241E).withOpacity(0.9),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green.withOpacity(0.5)),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 4),
                    ],
                  ),
                  child: IconButton(
                    onPressed: () async {
                      final mapState = ref.read(mapPresenterProvider);
                      if (mapState.activeTimesheet != null) {
                        // Show End dialog before exiting
                        final shouldExit = await showDialog<bool>(
                          context: context,
                          barrierDismissible: false,
                          builder: (ctx) => const TimesheetEndDialog(),
                        );

                        if (shouldExit == true && context.mounted) {
                          Navigator.of(context).pop();
                        }
                      } else {
                        // No active timesheet, just exit
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      }
                    },
                    icon: const Icon(Icons.exit_to_app, color: Colors.red),
                    tooltip: 'Exit Map',
                  ),
                ),
              ],
            ),
          ),

          // ===== BOTTOM INFO PANEL =====
          Positioned(
            bottom: size.height * 0.02,
            left: size.width * 0.02,
            right: size.width * 0.02,
            child: const MapInfoPanel(),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingButton({
    required IconData icon,
    required VoidCallback onPressed,
    Color? color,
  }) {
    final bgColor = const Color(0xFF1E241E).withOpacity(0.9);
    final fgColor = color ?? Colors.greenAccent;
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.green.withOpacity(0.5)),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
      ),
      child: FloatingActionButton(
        mini: true,
        backgroundColor: bgColor,
        foregroundColor: fgColor,
        elevation: 0,
        onPressed: onPressed,
        child: Icon(icon),
      ),
    );
  }
}
