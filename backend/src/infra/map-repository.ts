import { MapPlace, MapPlaceClient } from "../domain/map";
import { ResultAsync } from "neverthrow";
import { LanguageCode } from "../domain/language";
import { LatLng } from "../domain/location";
import { handleMapError, MapError } from "./error/map-error";
import { infraLogger } from "../logger";

export interface FetchNearbyPlacesArgs {
  languageCode: LanguageCode;
  latlng: LatLng;
}

export type FetchNearbyPlaces = (
  args: FetchNearbyPlacesArgs,
) => ResultAsync<MapPlace[], MapError>;

export const fetchNearbyPlaces =
  (mapPlace: MapPlaceClient): FetchNearbyPlaces =>
  ({ languageCode, latlng }: FetchNearbyPlacesArgs) =>
    ResultAsync.fromPromise(
      mapPlace.searchNearby({
        languageCode,
        maxResultCount: 3,
        locationRestriction: {
          circle: {
            center: {
              latitude: latlng.lat,
              longitude: latlng.lng,
            },
            // GPS の誤差は概ね 100m
            radius: 100,
          },
        },
      }),
      handleMapError,
    )
      .map((responses) =>
        responses
          .map((res) => (res && "places" in res ? (res.places ?? []) : []))
          .flat(),
      )
      .orTee(infraLogger.error);
