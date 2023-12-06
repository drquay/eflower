import { OrderDto } from "./order.dto";

export class OrderAttachmentDto {
    id?: string;
    name?: string;
    img?: string;
    thumbnail?: string;
    uploadedBy?: string;

    // Extend fields
    index1?: number
    order?: OrderDto;
}