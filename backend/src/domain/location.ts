import z from "zod";
import { Timestamp } from "./timestamp";

export const LatLng = z
  .object({
    lat: z.number(),
    lng: z.number(),
  })
  .openapi({ ref: "LatLng" });
export type LatLng = z.infer<typeof LatLng>;

export const Location = z
  .object({
    latlng: LatLng,
    createdAt: Timestamp,
    updatedAt: Timestamp,
  })
  .openapi({ ref: "Location" });
export type Location = z.infer<typeof Location>;
