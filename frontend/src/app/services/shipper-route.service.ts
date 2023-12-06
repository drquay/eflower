import { HttpClient, HttpHeaders } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { TokenService } from "@core";
import { environment } from "@env/environment";
import { Paging } from "app/dto/paging.dto";
import { ProductReqDto } from "app/dto/product-req.dto";
import { ShipperRouteForUpdateReq } from "app/dto/shipper-route-for-update.req";
import { ShipperRouteReq } from "app/dto/shipper-route.req";
import { ShipperRouteRes } from "app/dto/shipper-route.res";
import { Observable, of } from "rxjs";
import { catchError, map } from "rxjs/operators";

@Injectable({
    providedIn: 'root'
})
export class ShipperRouteService {

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

    beginOrEndRoute(shipperRouteForUpdateReq: ShipperRouteReq): Observable<string> {
        return this.httpClient.post<string>(`${environment.apiUrl}/api/shipper-routes`, shipperRouteForUpdateReq, this.httpOptions)
            .pipe(
                map((response: any) => response.data.id)
            );
    }

    update(id: string, shipperRouteForUpdateReq: ShipperRouteForUpdateReq): Observable<string> {
        return this.httpClient.put<string>(`${environment.apiUrl}/api/shipper-routes/${id}`, shipperRouteForUpdateReq, this.httpOptions)
            .pipe(
                map((response: any) => response.data)
            );
    }

    delete(id: string): Observable<boolean> {
        return this.httpClient.delete(`${environment.apiUrl}/api/shipper-routes/${id}`, this.httpOptions)
            .pipe(
                map((response: any) => response.data)
            );
    }

    findById(id: string): Observable<ShipperRouteRes> {
        return this.httpClient.get(`${environment.apiUrl}/api/shipper-routes/${id}`, this.httpOptions)
        .pipe(
            map((response: any) =>
                response.data as ShipperRouteRes
            )
        );
    }

    findByShipperId(id: string): Observable<ShipperRouteRes> {
        return this.httpClient.get(`${environment.apiUrl}/api/shipper-routes/shippers/${id}`, this.httpOptions)
        .pipe(
            map((response: any) =>
                response.data as ShipperRouteRes
            )
        );
    }

    listBySearch(params = {}): Observable<Paging<ShipperRouteRes>> {
        let httpOptions = {
            headers: new HttpHeaders({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${this.tokenService.getBearerToken()}`
            }),
            params: { ...params },
        };
        return this.httpClient.get<Paging<ShipperRouteRes>>(`${environment.apiUrl}/api/shipper-routes`, httpOptions)
            .pipe(
                map((response: any) =>
                    response.data as Paging<ShipperRouteRes>
                )
            );
    }
}