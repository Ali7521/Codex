import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../constants.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(37.7749, -122.4194),
    zoom: 14.4746,
  );

  final Set<Polygon> _zones = {
    Polygon(
      polygonId: const PolygonId('safe_zone_1'),
      points: const [
        LatLng(37.7749, -122.4194),
        LatLng(37.7849, -122.4194),
        LatLng(37.7849, -122.4094),
        LatLng(37.7749, -122.4094),
      ],
      fillColor: AppColors.safeZone.withOpacity(0.5),
      strokeColor: AppColors.safeZone,
      strokeWidth: 2,
    ),
    Polygon(
      polygonId: const PolygonId('danger_zone_1'),
      points: const [
        LatLng(37.7649, -122.4294),
        LatLng(37.7709, -122.4294),
        LatLng(37.7709, -122.4194),
        LatLng(37.7649, -122.4194),
      ],
      fillColor: AppColors.dangerZone.withOpacity(0.5),
      strokeColor: AppColors.dangerZone,
      strokeWidth: 2,
    ),
    Polygon(
      polygonId: const PolygonId('private_zone_1'),
      points: const [
        LatLng(37.7549, -122.4094),
        LatLng(37.7609, -122.4094),
        LatLng(37.7609, -122.3994),
        LatLng(37.7549, -122.3994),
      ],
      fillColor: AppColors.privateZone.withOpacity(0.5),
      strokeColor: AppColors.privateZone,
      strokeWidth: 2,
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Territory Map'),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _initialPosition,
        polygons: _zones,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Capture Zone'),
        icon: const Icon(Icons.flag),
        backgroundColor: AppColors.primaryOrange,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
