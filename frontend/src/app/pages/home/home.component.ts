import { ChangeDetectionStrategy, ChangeDetectorRef, Component, OnInit } from '@angular/core';

import { webSocket, WebSocketSubject } from 'rxjs/webSocket';
import { Observable } from 'rxjs';
import { environment } from "@env/environment";

interface Message {
  name: string; message: string; type: string;
}


@Component({
  selector: 'page-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss'],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class HomeComponent implements OnInit {


  messages: Message[] = [];
  name?: string;
  message?: string;

  ws?: WebSocketSubject<any>;

  message$?: Observable<Message>;

  connected?: boolean;

  constructor(
    private cdr: ChangeDetectorRef
  ){}

  ngOnInit() {
    this.connect();
  }


  connect() {
    // use wss:// instead of ws:// for a secure connection, e.g. in production
    this.ws = webSocket(`${environment.webSocketUrl}/notify`);

    //  split the subject into 2 observables, depending on object.type
    this.message$ = this.ws.multiplex(
      () => ({subscribe: 'message'}),
      () => ({unsubscribe: 'message'}),
      message => message.type === 'message'
    );

    // subscribe to messages sent from the server
    this.message$.subscribe(
      value => {this.messages.push(value); this.cdr.detectChanges()},
      error => this.disconnect(error),
      () => this.disconnect()
    );

    this.setConnected(true);
  }

  disconnect(err?: any) {
    if (err) { console.error(err); }
    this.setConnected(false);
    console.log('Disconnected');
  }

  sendMessage() {
    this.ws?.next({ name: this.name, message: this.message, type: 'message' });
    this.message = '';
  }

  setConnected(connected: any) {
    this.connected = connected;
    this.messages = [];
  }
  
}
