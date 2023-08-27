import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../ui/resource/fonts.dart';
import '../../ui/resource/ui_colors.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _MapPageContent();
  }
}

class _MapPageContent extends StatefulWidget {
  const _MapPageContent();

  @override
  State<_MapPageContent> createState() => _MapPageContentState();
}

class _MapPageContentState extends State<_MapPageContent> {
  Position? _currentPosition;
  final double _initLatitude = -6.2334;
  final double _initLongitude = 106.8812;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await _getCurrentPosition();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        FlutterMap(
          options: MapOptions(
            center: LatLng(
              _currentPosition?.latitude ?? _initLatitude,
              _currentPosition?.longitude ?? _initLongitude,
            ),
          ),
          children: <Widget>[
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.moviedb.app',
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: IntrinsicHeight(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                color: UiColors.warning,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Your current location',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: Fonts.sfProTextBold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Latitude : ${_currentPosition?.latitude}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: Fonts.sfProTextRegular,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Longitude : ${_currentPosition?.longitude}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: Fonts.sfProTextRegular,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (!context.mounted) {
        return false;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Location services are disabled. Please enable the services',
          ),
        ),
      );
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (!context.mounted) {
          return false;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Location permissions are denied'),
          ),
        );
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      if (!context.mounted) {
        return false;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Location permissions are permanently denied, we cannot request permissions.',
          ),
        ),
      );
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final bool hasPermission = await _handleLocationPermission();
    if (!hasPermission) {
      return;
    }
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(
        () {
          debugPrint('LATITUDE ${position.latitude}');
          debugPrint('LONGITUDE ${position.longitude}');
          _currentPosition = position;
        },
      );
    }).catchError((dynamic e) {
      debugPrint(e);
    });
  }
}
