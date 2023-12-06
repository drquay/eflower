import { HttpClient, HttpHeaders } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { TokenService } from "@core";
import { environment } from "@env/environment";
import { OrderStatusEnum } from "@shared/constants/order-status.enum";
import { Response } from "app/dto/response.dto";
import { IdRes } from "app/dto/id-res.dto";
import { OrderCreateReqDto } from "app/dto/order-create-req.dto";
import { OrderUpdateReqDto } from "app/dto/order-update-req.dto";
import { OrderDto } from "app/dto/order.dto";
import { Paging } from "app/dto/paging.dto";
import { Observable, of } from "rxjs";
import { catchError, map } from "rxjs/operators";
import { OrderResDto } from "app/dto/order-res.dto";
import { OrderStatusStatisticResDto } from "app/dto/order-status-statistic-res.dto";
import { ProfitReportResDto } from "app/dto/profit-report-res.dto";
import { ShipperStatisticResDto } from "app/dto/shipper-statistic-res.dto";

@Injectable({
    providedIn: 'root'
})
export class ReportService {

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

    statistic(): Observable<Response<OrderStatusStatisticResDto[]>> {
        let httpOptions = {
            headers: new HttpHeaders({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${this.tokenService.getBearerToken()}`
            })
        };
        return this.httpClient.get<Response<OrderStatusStatisticResDto[]>>(`${environment.apiUrl}/api/reports/order-statistic`, httpOptions);
    }

    profits(params = {}): Observable<Response<ProfitReportResDto[]>> {
        let httpOptions = {
            headers: new HttpHeaders({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${this.tokenService.getBearerToken()}`
            }),
            params: { ...params },
        };
        return this.httpClient.get<Response<ProfitReportResDto[]>>(`${environment.apiUrl}/api/reports/profits`, httpOptions);
    }

    shipperStatistic(params = {}): Observable<Response<ShipperStatisticResDto[]>> {
        let httpOptions = {
            headers: new HttpHeaders({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${this.tokenService.getBearerToken()}`
            }),
            params: { ...params },
        };
        return this.httpClient.get<Response<ShipperStatisticResDto[]>>(`${environment.apiUrl}/api/reports/shipper-statistic`, httpOptions);
    }

}