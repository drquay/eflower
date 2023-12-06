import { HttpClient, HttpHeaders } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { TokenService } from "@core";
import { environment } from "@env/environment";
import { AccountResDto } from "app/dto/account-res.dto";
import { AccountDto } from "app/dto/account.dto";
import { ChangePassReqDto } from "app/dto/change-pass-req.dto";
import { IdRes } from "app/dto/id-res.dto";
import { Paging } from "app/dto/paging.dto";
import { SignupReqDto } from "app/dto/signup-req.dto";
import { UpdateAccountInfoReqDto } from "app/dto/update-account-info-req.dto";
import { Observable, of } from "rxjs";
import { catchError, map } from "rxjs/operators";

@Injectable({
    providedIn: 'root'
})
export class AccountService {

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

    create(signupReqDto: SignupReqDto): Observable<IdRes> {
        return this.httpClient.post<string>(`${environment.apiUrl}/api/auth/signup`, signupReqDto, this.httpOptions)
            .pipe(
                map((response: any) => response.data.id)
            );
    }

    update(id: string, updateAccountInfoReqDto: UpdateAccountInfoReqDto): Observable<IdRes> {
        return this.httpClient.put<string>(`${environment.apiUrl}/api/accounts/${id}`, updateAccountInfoReqDto, this.httpOptions)
            .pipe(
                map((response: any) => response.data.id)
            );
    }

    changeAccountPassword(id: string, changePassReqDto: ChangePassReqDto): Observable<string> {
        return this.httpClient.post<string>(`${environment.apiUrl}/api/accounts/${id}/change-password`, changePassReqDto, this.httpOptions);
    }

    blockAccount(id: string): Observable<string> {
        return this.httpClient.put<string>(`${environment.apiUrl}/api/accounts/${id}/blocked`, null, this.httpOptions);
    }

    unblockAccount(id: string): Observable<string> {
        return this.httpClient.put<string>(`${environment.apiUrl}/api/accounts/${id}/un-blocked`, null, this.httpOptions);
    }

    listBySearch(params = {}): Observable<Paging<AccountResDto>> {
        let httpOptions = {
            headers: new HttpHeaders({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${this.tokenService.getBearerToken()}`
            }),
            params: { ...params },
        };
        return this.httpClient.get<Paging<AccountResDto>>(`${environment.apiUrl}/api/accounts`, httpOptions)
            .pipe(
                map((response: any) =>
                    response.data as Paging<AccountResDto>
                )
            );
    }
}