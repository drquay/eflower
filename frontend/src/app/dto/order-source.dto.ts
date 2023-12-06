import { OrderSource } from "@shared/constants/order-source.enum";
import { OrderStatusEnum } from "@shared/constants/order-status.enum";

export class OrderSourceDto {
    value?: OrderSource;
    name?: string;
}