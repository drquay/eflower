import { AttachmentResDto } from "./attachment-res.dto";

export class ProductResDto {
    id?: string;
    code?: string;
    description?: string;
    referenceUrl?: string;
    name?: string;
    price?: number;
    images?: AttachmentResDto[];
    createdOn?: string;

    // Extend fields
    
    index1?: number
}