import { OrderSource } from "@shared/constants/order-source.enum";
import { OrderPaymentReq } from "./order-payment-req.dto";

export class OrderUpdateReqDto {
    version?: number;
    productId?: string;
    code?: string;
    supportedSaleId?: string;
    price?: number;
    source?: OrderSource;
    deliveryDateTime?: string;
    buyerId?: string;
    receiverId?: string;
    deposit?: OrderPaymentReq;
    customerMessage?: string;
    noteForShipper?: string;
    noteForFlorist?: string;
}