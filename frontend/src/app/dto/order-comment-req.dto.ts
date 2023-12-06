import { AccountResDto } from "./account-res.dto";
import { AttachmentResDto } from "./attachment-res.dto";

export class OrderCommentReq {
    content?: string;
    attachmentIds?: string[];

    // Extend fields
    
    index1?: number
}