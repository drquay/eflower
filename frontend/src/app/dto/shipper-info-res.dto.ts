import { OrderStatusEnum } from "@shared/constants/order-status.enum";
import { AccountResDto } from "./account-res.dto";

export class ShippedInfoResDto {
    shipper?: AccountResDto;
    numberOfKm?: number;
}