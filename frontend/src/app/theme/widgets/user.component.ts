import { ChangeDetectorRef, Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { debounceTime, tap } from 'rxjs/operators';
import { AuthService, User } from '@core/authentication';
import { ChangePasswordComponent } from 'app/pages/account/change-password/change-password.component';
import { MtxDialog } from '@ng-matero/extensions/dialog';
import { AccountResDto } from 'app/dto/account-res.dto';

@Component({
  selector: 'app-user',
  template: `
    <button
      class="matero-toolbar-button matero-avatar-button"
      mat-button
      [matMenuTriggerFor]="menu"
    >
      <img class="matero-avatar" [src]="user.avatar" width="32" alt="avatar" />
      <span class="matero-username" fxHide.lt-sm>{{ user.name }}</span>
    </button>

    <mat-menu #menu="matMenu">
      <button mat-menu-item (click)="changePassword()">
        <mat-icon>vpn_key</mat-icon>
        <span>{{ 'user.changePassword' | translate }}</span>
      </button>
      <button mat-menu-item (click)="logout()">
        <mat-icon>exit_to_app</mat-icon>
        <span>{{ 'user.logout' | translate }}</span>
      </button>
    </mat-menu>
  `,
})
export class UserComponent implements OnInit {
  user!: User;

  constructor(
    private router: Router,
    private auth: AuthService,
    public dialog: MtxDialog,
    private cdr: ChangeDetectorRef,
    ) { }

  ngOnInit(): void {
    this.auth
      .user()
      .pipe(
        tap(user => (this.user = user)),
        debounceTime(10)
      )
      .subscribe(() => this.cdr.detectChanges());
  }

  changePassword() {
    let accountResDto = new AccountResDto();
    accountResDto.id = '' + this.user.id ?? '';
    const dialogRef = this.dialog.originalOpen(ChangePasswordComponent, {
      height: 'auto',
      maxHeight: '90vh',
      width: 'auto',
      data: accountResDto,
    });

    dialogRef.afterClosed().subscribe((result) => {
      if (result) {
        this.router.navigateByUrl('/auth/login');
      }
    });
  }

  logout() {
    this.auth.logout().subscribe(() => this.router.navigateByUrl('/auth/login'));
  }
}
