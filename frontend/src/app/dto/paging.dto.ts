export class Paging<T> {
    totalItems?: number;
    totalPages?: number;
    currentPage?: number;
    items?: T[] | null;
}