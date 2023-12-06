import { OrderStatusEnum } from "@shared/constants/order-status.enum";

export class OrderStatusStatisticResDto {
    status?: OrderStatusEnum;
    numberOfOrder?: number;
}