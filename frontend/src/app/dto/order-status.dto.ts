import { OrderStatusEnum } from "@shared/constants/order-status.enum";

export class OrderStatusDto {
    value?: OrderStatusEnum;
    name?: string;
    quantity: number = 0;
}