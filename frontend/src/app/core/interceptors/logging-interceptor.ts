import { HttpEvent, HttpHandler, HttpInterceptor, HttpRequest, HttpResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Token, User } from '@core/authentication';
import { MessageService } from '@shared';
import { UserComponent } from '@theme/widgets/user.component';
import { finalize, map, tap } from 'rxjs/operators';

@Injectable()
export class LoggingInterceptor implements HttpInterceptor {
  constructor(private messenger: MessageService) { }

  private changeToken(body: any) {
    let data = body.data;
    let user: User = {
      id: data.id,
      name: data.username,
      roles: data.privileges,
      avatar: data.avatar,
    }
    if (typeof(user.avatar) === 'undefined' || !user.avatar || user.avatar.length < 1) {
      user.avatar = './assets/images/avatars/avatar-1.jpg';
    }
    let token: Token = {
      access_token: body.data.token,
      token_type: '',
      expires_in: 24 * 60 * 60 * 60,
      exp: 24 * 60 * 60 * 60,
      refresh_token: ''
    }
    return { user, token };
  }

  intercept(req: HttpRequest<any>, next: HttpHandler) {
    const started = Date.now();
    let ok: string;


    // extend server response observable with logging
    return next.handle(req).pipe(
      tap(
        // Succeeds when there is a response; ignore other events
        event => (ok = event instanceof HttpResponse ? 'succeeded' : ''),
        // Operation failed; error is an HttpErrorResponse
        error => (ok = 'failed')
      ),
      map((event: HttpEvent<any>) => {
        // signin.
        if (event instanceof HttpResponse && event.url?.includes('/auth/signin')) {
          event = event.clone({ body: this.changeToken(event.body) });
        }
        return event;
      }),
      // Log when response observable either completes or errors
      finalize(() => {
        const elapsed = Date.now() - started;
        const msg = `${req.method} "${req.urlWithParams}" ${ok} in ${elapsed} ms.`;
        this.messenger.add(msg);
      })
    );
  }
}
