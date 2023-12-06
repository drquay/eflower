import { AccountResDto } from "./account-res.dto";
import { AttachmentResDto } from "./attachment-res.dto";

export class OrderPaymentHistoryRes {
    id?: string;
    type?: string;
    amount?: number;
    note?: string;
    moneyKeeper?: AccountResDto;
    attachments?: AttachmentResDto[];
    createdOn?: string;

    // Extend fields
    
    index1?: number
    typeName?: string;
}