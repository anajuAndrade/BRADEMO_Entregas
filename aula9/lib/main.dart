import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  try {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Localização desativada");
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
  } catch (e) {
    print(e);
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MapPage(),
    );
  }
}

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  static final _stream = Geolocator.getPositionStream();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Localização atual"),
      ),

      body: StreamBuilder<Position>(
        stream: _stream,
        builder: (context, positionData) {
          if (positionData.hasData) {
            final data = positionData.data;
            if (data != null) {
              final lat = data.latitude;
              final lon = data.longitude;
              return GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(lat, lon),
                  zoom: 16,
                ),
                markers: {
                  Marker(
                    markerId:
                        const MarkerId("localizacao"),
                    position: LatLng(lat, lon),
                    infoWindow: const InfoWindow(
                      title: "Loacalização atual",
                    ),
                  ),
                },
              );
            }
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}