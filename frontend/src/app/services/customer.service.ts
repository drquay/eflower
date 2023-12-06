import { HttpClient, HttpHeaders } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { TokenService } from "@core";
import { environment } from "@env/environment";
import { CustomerDto } from "app/dto/customer.dto";
import { Paging } from "app/dto/paging.dto";
import { Observable, of } from "rxjs";
import { catchError, map } from "rxjs/operators";

@Injectable({
    providedIn: 'root'
})
export class CustomerService {

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

    create(customerDto: CustomerDto): Observable<string> {
        return this.httpClient.post<string>(`${environment.apiUrl}/api/customers`, customerDto, this.httpOptions)
            .pipe(
                map((response: any) => response.data.id)
            );
    }

    update(id: string, customerDto: CustomerDto): Observable<string> {
        return this.httpClient.put<string>(`${environment.apiUrl}/api/customers/${id}`, customerDto, this.httpOptions)
            .pipe(
                map((response: any) => response.data.id)
            );
    }

    listBySearch(params = {}): Observable<Paging<CustomerDto>> {
        let httpOptions = {
            headers: new HttpHeaders({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${this.tokenService.getBearerToken()}`
            }),
            params: { ...params },
        };
        return this.httpClient.get<Paging<CustomerDto>>(`${environment.apiUrl}/api/customers`, httpOptions)
            .pipe(
                map((response: any) =>
                    response.data as Paging<CustomerDto>
                )
            );
    }
}