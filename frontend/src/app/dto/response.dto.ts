import { FError } from "./ferror.dto";

export class Response<T> {
    errors?: FError[];
    data?: T | null;
}