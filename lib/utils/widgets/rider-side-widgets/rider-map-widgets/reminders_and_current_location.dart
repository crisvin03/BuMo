import 'package:BuMo/utils/functions/map_functions.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RemindersAndCurrentLocation extends StatelessWidget {
  const RemindersAndCurrentLocation({
    super.key,
    required this.myMapController,
  });

  final GoogleMapController? myMapController;

  void _showRemindersDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ride Safety Reminders'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.safety_check, color: Colors.blue),
                title: Text('Always wear a helmet for safety.'),
              ),
              ListTile(
                leading: Icon(Icons.local_gas_station, color: Colors.green),
                title: Text('Check fuel and brakes before starting your ride.'),
              ),
              ListTile(
                leading: Icon(Icons.verified_user, color: Colors.orange),
                title: Text('Ensure proper verification of passengers.'),
              ),
              ListTile(
                leading: Icon(Icons.traffic, color: Colors.red),
                title: Text('Follow traffic rules and speed limits.'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 🛠️ Tap to Show Reminders Dialog
          GestureDetector(
            onTap: () => _showRemindersDialog(context),
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    spreadRadius: 5,
                    blurRadius: 10,
                  )
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'REMINDERS',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),

          // 📍 Move to current location
          GestureDetector(
            onTap: () async {
              Position position = await determinePosition();

              myMapController?.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: LatLng(position.latitude, position.longitude),
                    zoom: 16,
                  ),
                ),
              );
            },
            child: const PhysicalModel(
              color: Colors.black,
              elevation: 10.0,
              shape: BoxShape.circle,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                child: Icon(Icons.my_location,
                    color: Color.fromARGB(255, 25, 90, 158)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
