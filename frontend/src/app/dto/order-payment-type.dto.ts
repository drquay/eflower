import { OrderStatusEnum } from "@shared/constants/order-status.enum";
import { PaymentTypeEnum } from "@shared/constants/payment-type.enum";

export class OrderPaymentTypeDto {
    value?: PaymentTypeEnum;
    name?: string;
}