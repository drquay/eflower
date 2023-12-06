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
import { OrderPaymentReq } from "app/dto/order-payment-req.dto";
import { OrderCommentReq } from "app/dto/order-comment-req.dto";
import { UpdateOrderStatusReqDto } from "app/dto/update-order-status-req.dto";

@Injectable({
    providedIn: 'root'
})
export class OrderService {

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

    create(orderCreateReqDto: OrderCreateReqDto): Observable<string> {
        return this.httpClient.post<string>(`${environment.apiUrl}/api/orders`, orderCreateReqDto, this.httpOptions)
            .pipe(
                map((response: any) => response.data.id)
            );
    }

    update(id: string, orderUpdateReqDto: OrderUpdateReqDto): Observable<string> {
        return this.httpClient.put<string>(`${environment.apiUrl}/api/orders/${id}`, orderUpdateReqDto, this.httpOptions)
            .pipe(
                map((response: any) => response.data.id)
            );
    }

    delete(id: string): Observable<boolean> {
        return this.httpClient.delete<string>(`${environment.apiUrl}/api/orders/${id}`, this.httpOptions)
            .pipe(
                map((response: any) => response.data)
            );
    }

    addImagesToOrder(id: string, imageIds: string[]): Observable<any> {
        return this.httpClient.post<string>(`${environment.apiUrl}/api/orders/${id}/images`, imageIds, this.httpOptions);
    }

    reAssignedOrderTo(id: string, accountId: string): Observable<any> {
        let httpOptions = {
            headers: new HttpHeaders({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${this.tokenService.getBearerToken()}`
            }),
            params: { accountId },
        };
        return this.httpClient.put<Response<IdRes>>(`${environment.apiUrl}/api/orders/${id}/re-assigned`, null, httpOptions);
    }

    updateOrderStatus(id: string, updateOrderStatusReqDto: UpdateOrderStatusReqDto): Observable<any> {
        return this.httpClient.put<Response<IdRes>>(`${environment.apiUrl}/api/orders/${id}/statuses`, updateOrderStatusReqDto, this.httpOptions);
    }

    addComment(id: string, orderCommentReq: OrderCommentReq): Observable<any> {
        return this.httpClient.post<string>(`${environment.apiUrl}/api/orders/${id}/comments`, orderCommentReq, this.httpOptions);
    }

    updateComment(id: string, commentId: string, orderCommentReq: OrderCommentReq): Observable<any> {
        return this.httpClient.put<string>(`${environment.apiUrl}/api/orders/${id}/comments/${commentId}`, orderCommentReq, this.httpOptions);
    }

    deleteComment(id: string, commentId: string): Observable<any> {
        return this.httpClient.delete<boolean>(`${environment.apiUrl}/api/orders/${id}/comments/${commentId}`, this.httpOptions);
    }

    addPaymentHistory(id: string, orderPaymentReq: OrderPaymentReq): Observable<any> {
        return this.httpClient.post<string>(`${environment.apiUrl}/api/orders/${id}/payments`, orderPaymentReq, this.httpOptions);
    }

    updatePaymentHistory(id: string, paymentId: string, orderPaymentReq: OrderPaymentReq): Observable<any> {
        return this.httpClient.put<string>(`${environment.apiUrl}/api/orders/${id}/payments/${paymentId}`, orderPaymentReq, this.httpOptions);
    }

    deletePayment(id: string, paymentId: string): Observable<any> {
        return this.httpClient.delete<boolean>(`${environment.apiUrl}/api/orders/${id}/payments/${paymentId}`, this.httpOptions);
    }

    findById(id: string): Observable<OrderResDto> {
        return this.httpClient.get<OrderResDto>(`${environment.apiUrl}/api/orders/${id}`, this.httpOptions)
        .pipe(
            map((response: any) =>
                response.data as OrderResDto
            )
        );
    }

    listBySearch(params = {}): Observable<Paging<OrderResDto>> {
        let httpOptions = {
            headers: new HttpHeaders({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${this.tokenService.getBearerToken()}`
            }),
            params: { ...params },
        };
        return this.httpClient.get<Paging<OrderResDto>>(`${environment.apiUrl}/api/orders`, httpOptions)
            .pipe(
                map((response: any) =>
                    response.data as Paging<OrderResDto>
                )
            );
    }

    statistic(): Observable<Response<OrderStatusStatisticResDto[]>> {
        let httpOptions = {
            headers: new HttpHeaders({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${this.tokenService.getBearerToken()}`
            })
        };
        return this.httpClient.get<Response<OrderStatusStatisticResDto[]>>(`${environment.apiUrl}/api/orders/statistic`, httpOptions);
    }
}