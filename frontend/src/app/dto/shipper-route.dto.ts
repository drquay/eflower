import { ShipperRouteDetailDto } from "./shipper-route-detail.dto";

export class ShipperRouteDto {
    id?: string;
    version?: number;
    createdOn?: string;
    createdBy?: string;
    isNew?: boolean;

    shipperId?: string;
    numberOfKm?: number;
    beginLongitude?: string;
    beginLatitude?: string;
    endLongitude?: string;
    endLatitude?: string;
    details?: ShipperRouteDetailDto;
}