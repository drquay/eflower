import { ShipperRouteDetailRes } from "./shipper-route-detail.res";

export class ShipperRouteRes {
    id?: string;
    shipperId?: string;
    numberOfKm?: string;
    beginLongitude?: string;
    beginLatitude?: string;
    endLongitude?: string;
    endLatitude?: string;
    createdOn?: string;
    details?: ShipperRouteDetailRes[];

    // Extend fields
    
    index1?: number;
    shipperName?: string;
}