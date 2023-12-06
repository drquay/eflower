import { RouteType } from "@shared/constants/route-type.enum";

export class ShipperRouteReq {
    type?: RouteType;
    toLongitude?: string;
    toLatitude?: string;
    numberOfKm?: number;
}