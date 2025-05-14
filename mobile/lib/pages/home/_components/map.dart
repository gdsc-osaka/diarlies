import 'package:diarlies/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class JourneyMap extends StatelessWidget {
  const JourneyMap({super.key, required this.initialLocation});

  final LatLng initialLocation;

  @override
  Widget build(BuildContext context) {
    final styles = Styles.of(context);

    return Container(
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: styles.color.border,
          width: 4,
        ),
      ),
      // child: GoogleMap(initialCameraPosition: CameraPosition(
      //   target: initialLocation,
      //   zoom: 15,
      // )),
    );
  }
}
