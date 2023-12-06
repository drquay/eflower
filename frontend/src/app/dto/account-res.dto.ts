export class AccountResDto {
    id?: string;
    fullName?: string;
    phoneNumber?: string;
    username?: string;
    avatar?: string;
    blocked?: boolean;
    roles?: string[];
    createdOn?: string;

    // Extend fields
    
    index1?: number
}