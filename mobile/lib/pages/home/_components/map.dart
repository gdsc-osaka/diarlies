import 'package:diarlies/services/api_adapter.dart';
import 'package:diarlies/shared/formatter.dart';
import 'package:diarlies/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class JourneyMap extends HookWidget {
  const JourneyMap({super.key, required this.initialLocation, required this.locations});

  final LatLng initialLocation;
  final List<LocationHistory> locations;

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
        border: Border.all(color: styles.color.border, width: 4),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: GoogleMap(
          onMapCreated: handleMapCreated,
          compassEnabled: false,
          mapToolbarEnabled: false,
          myLocationButtonEnabled: false,
          myLocationEnabled: false,
          zoomControlsEnabled: false,
          initialCameraPosition: CameraPosition(target: initialLocation, zoom: 10),
          style: switch (styles.brightness) {
            Brightness.light => null,
            Brightness.dark => googleMapDarkStyle,
          },
          // draw a polyline so that each next point is connected
          polylines: {
            Polyline(
              polylineId: PolylineId('journey'),
              color: styles.color.primary,
              width: 4,
              points: locations.map((location) => LatLng(location.lat, location.lng)).toList(),
            ),
          },
        ),
      ),
    );
  }
}

const googleMapDarkStyle = """
[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#212121"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#212121"
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "administrative.country",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "administrative.locality",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#181818"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#1b1b1b"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#2c2c2c"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#8a8a8a"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#373737"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#3c3c3c"
      }
    ]
  },
  {
    "featureType": "road.highway.controlled_access",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#4e4e4e"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#000000"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#3d3d3d"
      }
    ]
  }
]
""";
