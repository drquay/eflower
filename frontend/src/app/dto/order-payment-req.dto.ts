import { PaymentTypeEnum } from "@shared/constants/payment-type.enum";
import { AccountResDto } from "./account-res.dto";
import { AttachmentResDto } from "./attachment-res.dto";

export class OrderPaymentReq {
    id?: string;
    type?: PaymentTypeEnum;
    amount?: number;
    note?: string;
    moneyKeeperId?: string;
    attachmentIds?: string[];

    // Extend fields
    
    index1?: number
}