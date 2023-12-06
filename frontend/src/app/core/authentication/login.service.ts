import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Menu } from '@core';
import { environment } from '@env/environment';
import { ajax } from 'rxjs/ajax';
import { map, switchMap } from 'rxjs/operators';
import { Token, User } from './interface';

@Injectable({
  providedIn: 'root',
})
export class LoginService {
  constructor(protected http: HttpClient) { }

  login(username: string, password: string, rememberMe = false) {
    return this.http.post<Token>(`${environment.apiUrl}/api/auth/signin`, { username, password });
  }

  refresh(params: Record<string, any>) {
    return this.http.post<Token>(`${environment.apiUrl}/api/auth/refresh`, params);
  }

  logout() {
    return this.http.post<any>(`${environment.apiUrl}/api/auth/logout`, {});
  }

  me() {
    return this.http.get<User>(`${environment.apiUrl}/api/auth/getUserInfo`);
  }

  menu() {
    return ajax('assets/data/menu.json?_t=' + Date.now())
    .pipe(
      map((response: any) => {
        return response.response.menu;
      })
    );
  }

  menu111() {
    return this.http.get<{ menu: Menu[] }>(`${environment.apiUrl}/api/auth/getMenu`).pipe(switchMap(res => 
      ajax('assets/data/menu.json?_t=' + Date.now())
      .pipe(
        map((response: any) => {
          return response.response.menu;
        })
      )));
  }
}
