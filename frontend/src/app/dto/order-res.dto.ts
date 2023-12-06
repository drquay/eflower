import { OrderSource } from "@shared/constants/order-source.enum";
import { OrderStatusEnum } from "@shared/constants/order-status.enum";
import { AccountResDto } from "./account-res.dto";
import { AccountDto } from "./account.dto";
import { AttachmentResDto } from "./attachment-res.dto";
import { CustomerDto } from "./customer.dto";
import { OrderAssignmentHistoryRes } from "./order-assignment-history-res.dto";
import { OrderAttachmentResDto } from "./order-attachment-res.dto";
import { OrderCommentRes } from "./order-comment-res.dto";
import { OrderPaymentHistoryRes } from "./order-payment-history-res.dto";
import { ProductResDto } from "./product-res.dto";

export class OrderResDto {
    version?: number;
    id?: string;
    code?: string;
    price?: number;
    source?: OrderSource;
    status?: OrderStatusEnum;
    customerMessage?: string;
    noteForShipper?: string;
    noteForFlorist?: string;
    createdOn?: string;
    createdBy?: string;
    deliveryDateTime?: string;
    deposit?: OrderPaymentHistoryRes;
    buyer?: CustomerDto;
    receiver?: CustomerDto;
    product?: ProductResDto;
    supportedSale?: AccountResDto;
    attachments?: AttachmentResDto[];
    paymentHistories?: OrderPaymentHistoryRes[];
    assignmentHistories?: OrderAssignmentHistoryRes[];
    comments?: OrderCommentRes[];

    // Extend fields
    
    index1?: number;
    sourceName?: string;
    buyerName?: string;
    receiverName?: string;
    statusName?: string;
}