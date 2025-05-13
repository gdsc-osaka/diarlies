import { PlacesClient } from "@googlemaps/places";

export type MapPlaceClient = InstanceType<typeof PlacesClient>;

export const createMapPlaceClient = (apiKey: string): MapPlaceClient => {
  return new PlacesClient({
    clientOptions: {
      apiKey,
    },
  });
};

export type MapPlace = {
  displayName: string;
  address: string;
};
