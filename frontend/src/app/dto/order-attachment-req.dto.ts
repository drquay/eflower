import { OrderAttachmentEnum } from "@shared/constants/order-attachment.enum";

export class OrderAttachmentReqDto {
    url?: string;
    name?: string;
    fileExtension?: string;

    // Extend fields
    
    status: OrderAttachmentEnum = OrderAttachmentEnum.NEW;
}