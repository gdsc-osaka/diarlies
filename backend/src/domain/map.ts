import { PlacesClient } from "@googlemaps/places";
import { google } from "@googlemaps/places/build/protos/protos";

export type MapPlaceClient = InstanceType<typeof PlacesClient>;

export const createMapPlaceClient = (apiKey: string): MapPlaceClient => {
  return new PlacesClient({
    clientOptions: {
      apiKey,
    },
  });
};

export type MapPlace = google.maps.places.v1.IPlace;
