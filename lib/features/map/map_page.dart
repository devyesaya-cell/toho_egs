import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maplibre/maplibre.dart';
import 'map_presenter.dart';
import 'widgets/guidance_widget.dart';
import 'widgets/map_info_panel.dart';

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

  void _toZoom(double zoom) async {
    if (_controller == null) return;
    _controller?.moveCamera(zoom: zoom);
  }

  @override
  Widget build(BuildContext context) {
    // Map State
    final mapState = ref.watch(mapPresenterProvider);
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
              options: MapOptions(
                // styleString: _styleString,
                initCenter: const Geographic(lon: 106.8456, lat: -6.2088),
                initZoom: _defaultZoom,
              ),
            ),
          ),

          // ===== TOP MENU BUTTON =====
          Positioned(
            top: size.height * 0.05,
            left: size.width * 0.02,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 4),
                ],
              ),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _showMenu = !_showMenu;
                  });
                },
                icon: const Icon(Icons.menu_rounded),
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
                        _toZoom(21.2);
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  // Zoom Out
                  _buildFloatingButton(
                    icon: Icons.zoom_out,
                    onPressed: () {
                      _toZoom(19.0);
                    },
                  ),
                  const SizedBox(height: 10),
                  // Work Mode Toggle
                  _buildFloatingButton(
                    icon: mapState.isWorkMode ? Icons.stop : Icons.play_arrow,
                    color: mapState.isWorkMode ? Colors.red : Colors.green,
                    onPressed: () {
                      ref.read(mapPresenterProvider.notifier).toggleWorkMode();
                    },
                  ),
                  const SizedBox(height: 10),
                  // Settings
                  _buildFloatingButton(
                    icon: Icons.settings,
                    color: Colors.amber,
                    onPressed: () {
                      // TODO: settings
                    },
                  ),
                ],
              ),
            ),

          // ===== GUIDANCE WIDGET =====
          if (mapState.isWorkMode)
            Positioned(
              right: size.width * 0.01,
              top: size.height * 0.09,
              child: const GuidanceWidget(),
            ),

          // ===== TOP RIGHT USB STATUS =====
          Positioned(
            top: size.height * 0.05,
            right: size.width * 0.02,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 4),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'USB: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.circle,
                    // Connected (Green) if usbConnected is true, else Red
                    color: mapState.usbConnected ? Colors.green : Colors.red,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    mapState.usbConnected ? 'Connected' : 'Not Connected',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
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
    Color color = Colors.blue,
  }) {
    return FloatingActionButton(
      mini: true,
      backgroundColor: color == Colors.blue ? Colors.white : color,
      foregroundColor: color == Colors.blue ? Colors.blue : Colors.white,
      onPressed: onPressed,
      child: Icon(icon),
    );
  }
}
