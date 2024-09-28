import 'dart:async';
import 'dart:math' show cos, sqrt, asin;

import 'package:flutter/material.dart';
import 'package:geofence_service/geofence_service.dart';
import 'package:geolocator/geolocator.dart' as gl;
import 'package:permission_handler/permission_handler.dart';
import 'package:timer_builder/timer_builder.dart';

class AttendanceApp extends StatefulWidget {
  @override
  _AttendanceAppState createState() => _AttendanceAppState();
}

class _AttendanceAppState extends State<AttendanceApp> {
  gl.Position? _currentPosition;
  bool _isWithinGeofence = false;
  Timer? _attendanceTimer;
  final int _requiredDurationInMinutes = 5; // Required time to stay inside the area
  int _elapsedMinutes = 0;

  double radius = 50;
  double? distance;

  // Initialize the GeofenceService
  final GeofenceService _geofenceService = GeofenceService.instance.setup(
    interval: 500,
    accuracy: 100,
    loiteringDelayMs: 1000,
  );

  @override
  void initState() {
    super.initState();
    _requestPermissions();
    // _getCurrentLocation();
    // _setupGeofence();
  }

  // Get current user location
  // void _getCurrentLocation() async {
  //   _currentPosition = await gl.Geolocator.getCurrentPosition(
  //       desiredAccuracy: gl.LocationAccuracy.high);
  //   print("#cl: $_currentPosition");
  //   setState(() {});
  // }
// Request permissions
  Future<void> _requestPermissions() async {
    // Request location and activity recognition permissions
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.activityRecognition,
    ].request();

    if (statuses[Permission.location]?.isGranted == true &&
        statuses[Permission.activityRecognition]?.isGranted == true) {
      // Permissions granted, proceed with geofencing and location tracking
      _getCurrentLocation();
      _setupGeofence();
      print("setup complet");
    } else if (statuses[Permission.activityRecognition]?.isPermanentlyDenied == true) {
      // Handle the case where the permission is permanently denied
      openAppSettings(); // Optionally open app settings to let the user enable the permission manually
    }
  }

  // void _getCurrentLocation() async {
  //   _currentPosition = await gl.Geolocator.getCurrentPosition(
  //       desiredAccuracy: gl.LocationAccuracy.high);
  //   print("#cl: $_currentPosition");
  //
  //   // Check if the user is already inside the geofence
  //   double distance = _calculateDistance(
  //     _currentPosition.latitude,
  //     _currentPosition.longitude,
  //     23.022505,  // Geofence latitude
  //     72.5713621, // Geofence longitude
  //   );
  //
  //   print("#dis: $distance");
  //
  //   // If the distance is less than the geofence radius, treat the user as inside the geofence
  //   if (distance <= 20000) {
  //     _onEnterGeofence();
  //   } else {
  //     _onExitGeofence();
  //   }
  //
  //   setState(() {});
  // }



  // Get current user location and check if inside geofence
  void _getCurrentLocation() async {
    _currentPosition = await gl.Geolocator.getCurrentPosition(
        desiredAccuracy: gl.LocationAccuracy.high);
    print("#cl: $_currentPosition");

    // Check if already within geofence
    distance = gl.Geolocator.distanceBetween(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
      23.1866333, // Geofence center latitude
      72.6284817, // Geofence center longitude
    );
    setState(() {});

    print("dist: $distance");
    if (distance != null && distance! <= radius) { // Geofence radius in meters
      _onEnterGeofence();
    } else {
      _onExitGeofence();
    }

    setState(() {});
  }

// Helper method to calculate distance between two lat/lng points in meters
  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const p = 0.017453292519943295; // Pi/18022
    final a = 0.5 - cos((lat2 - lat1) * p)/2 +
        cos(lat1 * p) * cos(lat2 * p) *
            (1 - cos((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a)) * 1000; // Distance in meters
  }


  // Define the geofence area (center latitude and longitude, radius in meters)
  void _setupGeofence() async {
    print("##");
    _geofenceService.addGeofence(
      Geofence(
        id: "attendance_area",
        latitude: 23.022505, // Example coordinates
        longitude: 72.5713621,
        radius: [GeofenceRadius(id: "r100m", length: radius)], // 1000 meters
      ),
    );

    // _geofenceService.

    // Add geofence listener
    _geofenceService.addGeofenceStatusChangeListener((Geofence geofence, GeofenceRadius geoRadius,
        GeofenceStatus geofenceStatus, Location location) async {
      print("#listening...: SS:${GeofenceStatus}");
      if (geofenceStatus == GeofenceStatus.ENTER) {
        print("#in");
        _onEnterGeofence();
      } else if (geofenceStatus == GeofenceStatus.EXIT) {
        print("#out");
        _onExitGeofence();
      }

    });
    print("#started");
    _geofenceService.start();
  }

  void _onEnterGeofence() {
    setState(() {
      _isWithinGeofence = true;
      _startTimer();
    });
  }

  void _onExitGeofence() {
    setState(() {
      _isWithinGeofence = false;
      _stopTimer();
    });
  }

  void _startTimer() {
    _attendanceTimer = Timer.periodic(Duration(minutes: 1), (timer) {
      print("_eT: $_elapsedMinutes");
      setState(() {
        _elapsedMinutes++;
      });

      // Check if the user has stayed for the required duration
      if (_elapsedMinutes >= _requiredDurationInMinutes) {
        _markAttendance();
        _stopTimer(); // Stop the timer once attendance is marked
      }
    });
  }

  void _stopTimer() {
    if (_attendanceTimer != null) {
      _attendanceTimer!.cancel();
      _attendanceTimer = null;
      _elapsedMinutes = 0; // Reset elapsed time
    }
  }

  // Mark attendance once the user stays within the geofence for the required time
  void _markAttendance() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Attendance marked successfully!"),
    ));
    // Here, you can add functionality to save the attendance in a database or other operations.
  }

  @override
  void dispose() {
    _geofenceService.stop();
    _stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Geofence Attendance App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isWithinGeofence)
              Text(
                'You are within the attendance area',
                style: TextStyle(fontSize: 18, color: Colors.green),
              ),
            if (!_isWithinGeofence)
              Text(
                'You are outside the attendance area',
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            SizedBox(height: 20),
            Text(
              'Time within area: $_elapsedMinutes minutes',
              style: TextStyle(fontSize: 16),
            ),

            Text(
              'distance: ${distance??""}',
              style: TextStyle(fontSize: 16),
            ),

            Text(
              'current location: ${_currentPosition ?? ""}',
              style: TextStyle(fontSize: 16),
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getCurrentLocation,
              child: Text("Get Current Location"),
            ),
          ],
        ),
      ),
    );
  }
}
