import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:geofence_service/geofence_service.dart';
import 'package:geolocator/geolocator.dart' as gl;
import 'package:permission_handler/permission_handler.dart';

class AttendanceApp extends StatefulWidget {
  @override
  _AttendanceAppState createState() => _AttendanceAppState();
}

class _AttendanceAppState extends State<AttendanceApp> {
  gl.Position? _currentPosition;
  bool _isWithinGeofence = false;
  Timer? _attendanceTimer;
  final int _requiredDurationInMinutes = 50; // Required time to stay inside the area
  int _elapsedMinutes = 0;
  double? _distance;

  final double lat = 23.1862499;
  final double long = 72.6285471;
  final double radius = 30;

  // GeofenceService instance
  // final GeofenceService _geofenceService = GeofenceService.instance.setup(
  //   interval: 500,
  //   accuracy: 100,
  //   loiteringDelayMs: 1000,
  // );

  @override
  void initState() {
    super.initState();
    _requestPermissions();

  }

  // Request necessary permissions
  Future<void> _requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.activityRecognition,
    ].request();

    if (statuses[Permission.location]?.isGranted == true &&
        statuses[Permission.activityRecognition]?.isGranted == true) {
      // _setupGeofence();

      _getCurrentLocation();
      _startTimer();
    } else if (statuses[Permission.activityRecognition]?.isPermanentlyDenied == true) {
      openAppSettings();
    }
  }

  // Setup geofence and add listeners
  // void _setupGeofence() async {
  //   _geofenceService.addGeofence(
  //     Geofence(
  //       id: "attendance_area",
  //       latitude: lat,
  //       longitude: long,
  //       radius: [GeofenceRadius(id: "r100m", length: radius)],
  //     ),
  //   );
  //
  //   _geofenceService.addGeofenceStatusChangeListener(
  //         (Geofence geofence, GeofenceRadius geoRadius, GeofenceStatus geofenceStatus, Location location) async {
  //       if (geofenceStatus == GeofenceStatus.ENTER) {
  //         _onEnterGeofence();
  //       } else if (geofenceStatus == GeofenceStatus.EXIT) {
  //         _onExitGeofence();
  //       }
  //       _getCurrentLocation(); // Always fetch the latest location
  //     },
  //   );
  //
  //   _geofenceService.start();
  // }

  // Get current location and check if within geofence
  Future<void> _getCurrentLocation() async {
    _currentPosition = await gl.Geolocator.getCurrentPosition(
      desiredAccuracy: gl.LocationAccuracy.high,
    );

    if (_currentPosition != null) {
      _distance = gl.Geolocator.distanceBetween(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
        lat,
        long,
      );
      if (_distance != null && _distance! <= radius) {
        _onEnterGeofence();
      } else {
        _onExitGeofence();
      }
      setState(() {}); // Update UI only once
    }
  }

  // Handle entering geofence
  void _onEnterGeofence() {
    if (!_isWithinGeofence) {
      setState(() {
        _isWithinGeofence = true;
      });
      // _startTimer();
    }
  }

  // Handle exiting geofence
  void _onExitGeofence() {
    if (_isWithinGeofence) {
      setState(() {
        _isWithinGeofence = false;
      });
      // _stopTimer();
    }
  }

  // Start the attendance timer
  void _startTimer() {
    _attendanceTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      _getCurrentLocation();
      if((_distance??double.infinity) <= radius){
        _elapsedMinutes++;
        if (_elapsedMinutes >= _requiredDurationInMinutes) {
          _markAttendance();
          _stopTimer();
        }
      }

    });
  }


  // Stop the attendance timer
  void _stopTimer() {
    _attendanceTimer?.cancel();
    _attendanceTimer = null;
    _elapsedMinutes = 0;
  }

  // Mark attendance and show a success message
  void _markAttendance() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Attendance marked successfully!"),
    ));
  }

  @override
  void dispose() {
    // _geofenceService.stop();
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
            Text(
              _isWithinGeofence
                  ? 'You are within the attendance area'
                  : 'You are outside the attendance area',
              style: TextStyle(fontSize: 18, color: _isWithinGeofence ? Colors.green : Colors.red),
            ),
            SizedBox(height: 20),
            Text(
              'Time within area: $_elapsedMinutes Seconds',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            if (_distance != null)
              Text(
                'Distance: ${_distance?.toStringAsFixed(2)} meters',
                style: TextStyle(fontSize: 16),
              ),
            SizedBox(height: 20),
            if (_currentPosition != null)
              Text(
                'Current Location: Lat: ${_currentPosition?.latitude}, Long: ${_currentPosition?.longitude}',
                style: TextStyle(fontSize: 16),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getCurrentLocation,
              child: Text("Get Current Location"),
            ),

            ElevatedButton(

              onPressed: (){
                _stopTimer();
                _startTimer();
              },
              child: Text("Reset"),
            ),
          ],
        ),
      ),
    );
  }
}
