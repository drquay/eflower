import { OrderAttachmentEnum } from "@shared/constants/order-attachment.enum";
import { AccountResDto } from "./account-res.dto";

export class OrderAttachmentResDto {
    id?: string;
    url?: string;
    name?: string;
    fileExtension?: string;
    uploadedBy?: AccountResDto;

    // Extend fields
    
    status: OrderAttachmentEnum = OrderAttachmentEnum.NEW;
}