import { OrderStatusEnum } from "@shared/constants/order-status.enum";
import { AccountResDto } from "./account-res.dto";
import { ShippedInfoResDto } from "./shipper-info-res.dto";

export class ShipperStatisticResDto {
    reportDate?: string;
    data?: ShippedInfoResDto[];
}