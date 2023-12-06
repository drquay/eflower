import { HttpClient, HttpHeaders } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { TokenService } from "@core";
import { environment } from "@env/environment";
import { AccountResDto } from "app/dto/account-res.dto";
import { AccountDto } from "app/dto/account.dto";
import { IdRes } from "app/dto/id-res.dto";
import { Paging } from "app/dto/paging.dto";
import { SignupReqDto } from "app/dto/signup-req.dto";
import { UpdateAccountInfoReqDto } from "app/dto/update-account-info-req.dto";
import { Observable, of } from "rxjs";
import { catchError, map } from "rxjs/operators";

@Injectable({
    providedIn: 'root'
})
export class ConfigurationService {

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

    listRoles(): Observable<string[]> {
        return this.httpClient.get<string[]>(`${environment.apiUrl}/api/configurations/roles`, this.httpOptions)
            .pipe(
                map((response: any) =>
                    response.data as string[]
                )
            );
    }

    listOrderStatuses(): Observable<string[]> {
        return this.httpClient.get<string[]>(`${environment.apiUrl}/api/configurations/order-statuses`, this.httpOptions)
            .pipe(
                map((response: any) =>
                    response.data as string[]
                )
            );
    }

}