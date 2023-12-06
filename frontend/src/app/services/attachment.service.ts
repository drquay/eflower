import { HttpClient, HttpHeaders } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { TokenService } from "@core";
import { environment } from "@env/environment";
import { AttachmentReqDto } from "app/dto/attachment-req.dto";
import { Observable, of } from "rxjs";
import { map } from "rxjs/operators";

@Injectable({
    providedIn: 'root'
})
export class AttachmentService {

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

    create(attachmentReqDto: AttachmentReqDto): Observable<string> {
        return this.httpClient.post<string>(`${environment.apiUrl}/api/attachments`, attachmentReqDto, this.httpOptions)
            .pipe(
                map((response: any) => response.data.id)
            );
    }

    delete(id: string): Observable<any> {
        return this.httpClient.delete<any>(`${environment.apiUrl}/api/attachments/${id}`, this.httpOptions);
    }
}