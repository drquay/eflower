import { OrderStatusEnum } from "@shared/constants/order-status.enum";

export class UpdateOrderStatusReqDto {
    version?: number;
    status?: OrderStatusEnum;
}