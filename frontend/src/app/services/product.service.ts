import { HttpClient, HttpHeaders } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { TokenService } from "@core";
import { environment } from "@env/environment";
import { Paging } from "app/dto/paging.dto";
import { ProductReqDto } from "app/dto/product-req.dto";
import { Observable, of } from "rxjs";
import { catchError, map } from "rxjs/operators";

@Injectable({
    providedIn: 'root'
})
export class ProductService {

    constructor(private httpClient: HttpClient, private tokenService: TokenService) { }

    /**
    * Handle Http operation that failed.
    * Let the app continue.
    *
    * @param operation - name of the operation that failed
    * @param result - optional value to return as the observable result
    */
    private handleError<T>(operation = 'operation', result?: T) {
        return (error: any): Observable<T> => {

            // TODO: send the error to remote logging infrastructure
            console.error(error); // log to console instead

            // Let the app keep running by returning an empty result.
            return of(result as T);
        };
    }

    httpOptions = {
        headers: new HttpHeaders({
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${this.tokenService.getBearerToken()}`
        }),
    };

    create(productReqDto: ProductReqDto): Observable<string> {
        return this.httpClient.post<string>(`${environment.apiUrl}/api/products`, productReqDto, this.httpOptions)
            .pipe(
                map((response: any) => response.data.id)
            );
    }

    update(id: string, productReqDto: ProductReqDto): Observable<string> {
        return this.httpClient.put<string>(`${environment.apiUrl}/api/products/${id}`, productReqDto, this.httpOptions)
            .pipe(
                map((response: any) => response.data.id)
            );
    }

    delete(id: string): Observable<boolean> {
        return this.httpClient.delete<string>(`${environment.apiUrl}/api/products/${id}`, this.httpOptions)
            .pipe(
                map((response: any) => response.data)
            );
    }

    listBySearch(params = {}): Observable<Paging<ProductReqDto>> {
        let httpOptions = {
            headers: new HttpHeaders({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${this.tokenService.getBearerToken()}`
            }),
            params: { ...params },
        };
        return this.httpClient.get<Paging<ProductReqDto>>(`${environment.apiUrl}/api/products`, httpOptions)
            .pipe(
                map((response: any) =>
                    response.data as Paging<ProductReqDto>
                )
            );
    }
}