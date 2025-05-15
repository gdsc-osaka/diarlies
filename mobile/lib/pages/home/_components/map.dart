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
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: styles.color.greenPastel,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: styles.color.border,
          width: 4,
        ),
      ),
      child: Text('Wip', style: styles.text.title.s),
      // child: GoogleMap(initialCameraPosition: CameraPosition(
      //   target: initialLocation,
      //   zoom: 15,
      // )),
    );
  }
}
