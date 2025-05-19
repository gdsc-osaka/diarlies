import 'package:diarlies/shared/formatter.dart';
import 'package:diarlies/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_model/hive_model.dart';

class JourneyMap extends HookWidget {
  const JourneyMap({super.key, required this.initialLocation, required this.locations});

  final LatLng initialLocation;
  final List<LocationPoint> locations;

  @override
  Widget build(BuildContext context) {
    final styles = Styles.of(context);
    final controller = useState<GoogleMapController?>(null);

    handleMapCreated(GoogleMapController c) {
      controller.value = c;
    }

    useEffect(() {
      if (controller.value != null && locations.isNotEmpty) {
        controller.value!.animateCamera(
          CameraUpdate.newLatLngBounds(
            LatLngBounds(
              southwest: LatLng(
                locations.map((e) => e.lat).reduce((a, b) => a < b ? a : b),
                locations.map((e) => e.lng).reduce((a, b) => a < b ? a : b),
              ),
              northeast: LatLng(
                locations.map((e) => e.lat).reduce((a, b) => a > b ? a : b),
                locations.map((e) => e.lng).reduce((a, b) => a > b ? a : b),
              ),
            ),
            100,
          ),
        );
      }

      return () {
        controller.value?.dispose();
      };
    }, [controller.value]);

    return Container(
      height: 80,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: styles.color.greenPastel,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: styles.color.border,
          width: 4,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: GoogleMap(
          onMapCreated: handleMapCreated,
            compassEnabled: false,
            mapToolbarEnabled: false,
            myLocationButtonEnabled: false,
            myLocationEnabled: false,
            initialCameraPosition: CameraPosition(
          target: initialLocation,
          zoom: 10,
        ),
          markers: locations.map((location) {
            return Marker(
              markerId: MarkerId(location.key.toString()),
              position: LatLng(location.lat, location.lng),
              infoWindow: InfoWindow(
                title: hhmmFormatter.format(location.createdAt),
              ),
            );
          }).toSet(),
        ),
      ),
    );
  }
}
