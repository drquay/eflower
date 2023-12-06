import { Injectable } from '@angular/core';
import { LocalStorageService } from '@shared';
import { User } from './interface';

@Injectable({
  providedIn: 'root',
})
export class UserService {
  private key = 'eflower-user';
  private _user?: User;

  constructor(private store: LocalStorageService) { }

  get<User>() {
    return this.store.get(this.key);
  }

  save(user?: User): void {
    this._user = undefined;

    if (!user) {
      this.store.remove(this.key);
    } else {
      this._user = user;
      this.store.set(this.key, user);
    }
  }

  clear() {
    this.store.remove(this.key);
  }
}
