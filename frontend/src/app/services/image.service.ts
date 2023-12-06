import { HttpClient, HttpEvent, HttpEventType, HttpHeaders, HttpRequest } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { TokenService } from "@core";
import { environment } from "@env/environment";
import { AttachmentReqDto } from "app/dto/attachment-req.dto";
import { Observable, of } from "rxjs";
import { catchError, last, map, tap } from "rxjs/operators";

@Injectable({
  providedIn: 'root'
})
export class ImageService {
  private readonly IMGUR_UPLOAD_URL = 'https://api.imgur.com/3/image';
  private readonly clientId = '2614bfc81ecf30a';
  private readonly token = '5eeae49394cd929e299785c8805bd168fc675280';

  constructor(private httpClient: HttpClient, private tokenService: TokenService) { }

  httpOptions = {
    headers: new HttpHeaders({
      'Authorization': `Bearer ${this.tokenService.getBearerToken()}`
    }),
  };

  upload(file: File): Observable<string> {
    const formData: FormData = new FormData();
    formData.append('file', file);
    return this.httpClient.post(`${environment.apiUrl}/uploadFile`, formData, this.httpOptions)
      .pipe(
        map((response: any) => response.data.link)
      );
  }

  uploadAvatar(file: File): Observable<string> {
    const formData: FormData = new FormData();
    formData.append('file', file);
    return this.httpClient.post(`${environment.apiUrl}/uploadAvatar`, formData, this.httpOptions)
      .pipe(
        map((response: any) => response.data.link)
      );
  }

}