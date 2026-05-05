import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'package:terpiez/models/app_state.dart';
import 'package:terpiez/models/terpiez_location.dart';

class FinderTab extends StatefulWidget {
  const FinderTab({super.key});

  @override
  State<FinderTab> createState() => _FinderTabState();
}

class _FinderTabState extends State<FinderTab> {
  static const double _catchDistanceMeters = 10.0;

  static const List<TerpiezLocation> _terpiezLocations = [
    TerpiezLocation(name: 'Fire Terpiez', lat: 38.98601, lng: -76.94450),
    TerpiezLocation(name: 'Water Terpiez', lat: 38.98830, lng: -76.94410),
    TerpiezLocation(name: 'Grass Terpiez', lat: 38.98930, lng: -76.94840),
  ];

  static const LatLng _umdDefault = LatLng(38.9869, -76.9426);

  GoogleMapController? _mapController;
  Position? _currentPosition;
  StreamSubscription<Position>? _positionStream;
  double? _nearestDistance;

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    _mapController?.dispose();
    super.dispose();
  }

  Future<void> _initLocation() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }
    if (permission == LocationPermission.deniedForever) return;

    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    ).listen(_onPositionUpdate);
  }

  void _onPositionUpdate(Position position) {
    final nearest = _computeNearestDistance(position);
    setState(() {
      _currentPosition = position;
      _nearestDistance = nearest;
    });
    _mapController?.animateCamera(
      CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)),
    );
  }

  double _computeNearestDistance(Position position) {
    double? min;
    for (final t in _terpiezLocations) {
      final d = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        t.lat,
        t.lng,
      );
      if (min == null || d < min) min = d;
    }
    return min ?? double.infinity;
  }

  Set<Marker> _buildMarkers() {
    return _terpiezLocations
        .map(
          (t) => Marker(
            markerId: MarkerId(t.name),
            position: LatLng(t.lat, t.lng),
            infoWindow: InfoWindow(title: t.name),
          ),
        )
        .toSet();
  }

  String _formatDistance(double meters) {
    if (meters >= 1000) {
      return '${(meters / 1000).toStringAsFixed(2)} km';
    }
    return '${meters.toStringAsFixed(0)} m';
  }

  @override
  Widget build(BuildContext context) {
    final canCatch =
        _nearestDistance != null && _nearestDistance! <= _catchDistanceMeters;

    final initialPosition = CameraPosition(
      target: _currentPosition != null
          ? LatLng(_currentPosition!.latitude, _currentPosition!.longitude)
          : _umdDefault,
      zoom: 17,
    );

    return Column(
      children: [
        Expanded(
          child: GoogleMap(
            initialCameraPosition: initialPosition,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            markers: _buildMarkers(),
            onMapCreated: (controller) => _mapController = controller,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              Text(
                _nearestDistance != null
                    ? 'Nearest Terpiez: ${_formatDistance(_nearestDistance!)}'
                    : 'Locating...',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: canCatch
                      ? () => context.read<AppState>().incrementTerpiezCaught()
                      : null,
                  child: const Text('Catch Terpiez'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
