import { AccountResDto } from "./account-res.dto";
import { AttachmentResDto } from "./attachment-res.dto";

export class OrderCommentRes {
    id?: string;
    content?: string;
    attachments?: AttachmentResDto[];
    createdOn?: string;

    // Extend fields
    
    index1?: number
}