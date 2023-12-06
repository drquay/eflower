import { ChangeDetectorRef, Component, OnDestroy, OnInit } from '@angular/core';
import { environment } from "@env/environment";

import { webSocket, WebSocketSubject } from 'rxjs/webSocket';
import { Observable } from 'rxjs';
import { ToastrService } from 'ngx-toastr';

interface Message {
  name: string; message: string; type: string;
}

@Component({
  selector: 'app-sidebar-notice',
  templateUrl: './sidebar-notice.component.html',
  styleUrls: ['./sidebar-notice.component.scss'],
})
export class SidebarNoticeComponent implements OnInit, OnDestroy {

  ws?: WebSocketSubject<any>;
  message$?: Observable<Message>;
  connected?: boolean;

  messages: Message[] = [];
  selectedMessage?: Message;

  constructor(
    private cdr: ChangeDetectorRef,
    private toast: ToastrService
  ){}

  ngOnInit() {
    this.connect();
  }

  ngOnDestroy() {
    this.ws?.complete();
  }

  connect() {
    this.ws = webSocket(`${environment.webSocketUrl}/notify`);

    this.message$ = this.ws.multiplex(
      () => ({subscribe: 'message'}),
      () => ({unsubscribe: 'message'}),
      message => message.type === 'message'
    );

    // subscribe to messages sent from the server
    this.message$.subscribe(
      value => {
        this.messages.push(value);
        this.toast.info(value.message);
        this.cdr.detectChanges();
      },
      error => this.disconnect(error),
      () => this.disconnect()
    );
  }

  disconnect(err?: any) {
    if (err) { console.error(err); }
    this.setConnected(false);
    console.log('Disconnected');
  }

  setConnected(connected: any) {
    this.connected = connected;
    this.messages = [];
  }

  onSelect(message: Message): void {
    this.selectedMessage = message;
  }

}
