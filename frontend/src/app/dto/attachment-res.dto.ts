import { OrderAttachmentEnum } from "@shared/constants/order-attachment.enum";
import { AccountResDto } from "./account-res.dto";

export class AttachmentResDto {
    id?: string;
    url?: string;
    name?: string;
    uploadedBy?: AccountResDto;
    createdOn?: string;

    // Extend fields
    
    index1?: number
    status: OrderAttachmentEnum = OrderAttachmentEnum.NEW;
}