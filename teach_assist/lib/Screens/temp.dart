import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geofence_service/geofence_service.dart';
import 'package:geolocator/geolocator.dart' as gl;
import 'package:timer_builder/timer_builder.dart';

class AttendanceApp extends StatefulWidget {
  @override
  _AttendanceAppState createState() => _AttendanceAppState();
}

class _AttendanceAppState extends State<AttendanceApp> {
  late gl.Position _currentPosition;
  bool _isWithinGeofence = false;
  Timer? _attendanceTimer;
  final int _requiredDurationInMinutes = 5; // Required time to stay inside the area
  int _elapsedMinutes = 0;

  // Initialize the GeofenceService
  final GeofenceService _geofenceService = GeofenceService.instance.setup(
    interval: 5000,
    accuracy: 100,
    loiteringDelayMs: 10000,
  );

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _setupGeofence();
  }

  // Get current user location
  void _getCurrentLocation() async {
    _currentPosition = await gl.Geolocator.getCurrentPosition(
        desiredAccuracy: gl.LocationAccuracy.high);
    print("#cl: $_currentPosition");
    setState(() {});
  }

  // Define the geofence area (center latitude and longitude, radius in meters)
  void _setupGeofence() async {
    print("##");
    _geofenceService.addGeofence(
      Geofence(
        id: "attendance_area",
        latitude: 23.022505, // Example coordinates
        longitude: 72.5713621,
        radius: [GeofenceRadius(id: "r100m", length: 100)], // 100 meters
      ),
    );

    // _geofenceService.

    // Add geofence listener
    _geofenceService.addGeofenceStatusChangeListener((Geofence geofence, GeofenceRadius geoRadius,
        GeofenceStatus geofenceStatus, Location location) async {
      print("#listening...");
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
