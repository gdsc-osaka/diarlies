import z from "zod";
import {ServiceError} from "../../service/error/service-error";

export const ApiError = z
    .object({
        code: z.string(),
        message: z.string(),
    })
    .openapi({ ref: "ApiError" });
export type ApiError = z.infer<typeof ApiError>;

export const convertToApiError = (serviceError: ServiceError): ApiError => {
    return {
        code: serviceError.code,
        message: serviceError.message,
    };
}