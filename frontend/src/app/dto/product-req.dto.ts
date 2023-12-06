import { AttachmentResDto } from "./attachment-res.dto";

export class ProductReqDto {
    code?: string;
    description?: string;
    referenceUrl?: string;
    name?: string;
    price?: number;
    imgIds?: string[];

    // Extend fields
    
    index1?: number;
    images?: AttachmentResDto[];
}