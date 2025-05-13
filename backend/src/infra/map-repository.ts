import { MapPlace, MapPlaceClient } from "../domain/map";
import { okAsync, ResultAsync } from "neverthrow";
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
      mapPlace.searchNearby(
        {
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
        },
        {
          otherArgs: {
            headers: {
              "X-Goog-FieldMask": "places.displayName,",
            },
          },
        },
      ),
      handleMapError,
    )
      .map((responses) =>
        responses
          .map((res) => (res && "places" in res ? (res.places ?? []) : []))
          .flat()
          .map((place) => ({
            displayName: place.displayName!.text!,
            address: place.formattedAddress!,
          })),
      )
      .orTee(infraLogger.error);

export const fakeFetchNearbyPlaces: FetchNearbyPlaces = () => okAsync([]);
