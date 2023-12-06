import { OrderSource } from "@shared/constants/order-source.enum";
import { OrderStatusEnum } from "@shared/constants/order-status.enum";
import { AccountDto } from "./account.dto";
import { CustomerDto } from "./customer.dto";
import { OrderAttachmentDto } from "./order-attachment.dto";

export class OrderDto {
    id?: string;
    code?: string;
    productId?: string;
    price?: number;
    source?: OrderSource;
    status?: OrderStatusEnum;
    deliveryDateTime?: string;
    customerMessage?: string;
    noteForShipper?: string;
    noteForFlorist?: string;
    buyerId?: string;
    receiverId?: string;
    supportedSaleId?: string;
    attachments?: OrderAttachmentDto[];

    // Extend fields

    index1?: number
    buyer?: CustomerDto;
    buyerName?: string;
    receiver?: CustomerDto;
    receiverName?: string;
    supportedSale?: AccountDto;
    supportedSaleName?: string;
}