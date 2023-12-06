import { ShipperRouteDto } from "./shipper-route.dto";

export class ShipperRouteDetailDto {
    id?: string;
    version?: number;
    createdOn?: string;
    createdBy?: string;
    isNew?: boolean;

    orderId?: string;
    toLongitude?: string;
    toLatitude?: string;
    route?: ShipperRouteDto;
}