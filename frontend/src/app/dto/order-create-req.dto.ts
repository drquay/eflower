import { OrderSource } from "@shared/constants/order-source.enum";
import { OrderPaymentReq } from "./order-payment-req.dto";

export class OrderCreateReqDto {
    id?: string;
    productId?: string;
    price?: number;
    source?: OrderSource;
    deliveryDateTime?: string;
    supportedSaleId?: string;
    buyerId?: string;
    receiverId?: string;
    customerMessage?: string;
    noteForShipper?: string;
    noteForFlorist?: string;
    attachmentIds?: string[];
    deposit?: OrderPaymentReq;
}