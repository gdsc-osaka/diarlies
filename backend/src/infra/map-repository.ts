import { MapPlace, MapPlaceClient } from "../domain/map";
import { okAsync, ResultAsync } from "neverthrow";
import { LanguageCode } from "../domain/language";
import { handleMapError, MapError } from "./error/map-error";
import { infraLogger } from "../logger";

export interface FetchNearbyPlacesArgs {
  languageCode: LanguageCode;
  lat: number;
  lng: number;
}

export type FetchNearbyPlaces = (
  args: FetchNearbyPlacesArgs,
) => ResultAsync<MapPlace[], MapError>;

export const fetchNearbyPlaces =
  (mapPlace: MapPlaceClient): FetchNearbyPlaces =>
  ({ languageCode, lng, lat }: FetchNearbyPlacesArgs) =>
    ResultAsync.fromPromise(
      mapPlace.searchNearby(
        {
          languageCode,
          maxResultCount: 3,
          locationRestriction: {
            circle: {
              center: {
                latitude: lat,
                longitude: lng,
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
      .orTee(infraLogger("fetchNearbyPlaces").error);

export const fakeFetchNearbyPlaces: FetchNearbyPlaces = () => okAsync([]);
