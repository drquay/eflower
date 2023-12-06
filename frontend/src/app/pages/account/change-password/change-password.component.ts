import { Component, OnInit, Inject } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { DateAdapter } from '@angular/material/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { ActivatedRoute } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { AccountResDto } from 'app/dto/account-res.dto';
import { AccountDto } from 'app/dto/account.dto';
import { ChangePassReqDto } from 'app/dto/change-pass-req.dto';
import { SignupReqDto } from 'app/dto/signup-req.dto';
import { UpdateAccountInfoReqDto } from 'app/dto/update-account-info-req.dto';
import { AccountService } from 'app/services/account.service';
import { Subscription } from 'rxjs';

@Component({
  selector: 'page-change-password',
  templateUrl: './change-password.component.html',
  styleUrls: ['./change-password.component.scss'],
  providers: [AccountService],
})
export class ChangePasswordComponent implements OnInit {
  translateSubscription!: Subscription;
  reactiveForm: FormGroup;
  editItem: AccountResDto = new AccountResDto();
  editMode: boolean = false;

  // "PRI_ADMIN", "ADMINISTRATOR_PRIVILEGE",
  // "PRI_SALE", "SALE_PRIVILEGE",
  // "PRI_FLORIST", "FLORIST_PRIVILEGE",
  // "PRI_SHIPPER", "SHIPPER_PRIVILEGE"
  lstRolesDto: any[] = [
    { value: 'FLORIST', name: 'Thợ' },
    { value: 'SHIPPER', name: 'Người giao hàng' },
    { value: 'SALE', name: 'Nhân viên sale' },
    { value: 'ADMIN', name: 'Admin' }
  ];

  constructor(
    private fb: FormBuilder,
    private dateAdapter: DateAdapter<any>,
    private translate: TranslateService,
    private route: ActivatedRoute,
    public dialogRef: MatDialogRef<ChangePasswordComponent>,
    @Inject(MAT_DIALOG_DATA) public data: AccountDto,

    private accountService: AccountService,
  ) {

    this.editItem = data;
    this.editMode = Object.keys(this.editItem).length > 0;

    this.reactiveForm = this.fb.group({
      oldPass: ['', [Validators.required]],
      password: ['', [Validators.required]],
      confirmPassword: ['', [this.confirmValidator]],
    });

  }

  ngOnInit() {
    this.translateSubscription = this.translate.onLangChange.subscribe((res: { lang: any }) => {
      this.dateAdapter.setLocale(res.lang);
    });
  }

  confirmValidator = (control: FormControl): { [k: string]: boolean } => {
    if (!control.value) {
      return { error: true, required: true };
    } else if (control.value !== this.reactiveForm.controls.password.value) {
      return { error: true, confirm: true };
    }
    return {};
  };

  ngOnDestroy() {
    this.translateSubscription.unsubscribe();
  }

  getErrorMessage(form: FormGroup) {
    return form.get('email')?.hasError('required')
      ? 'validations.required'
      : form.get('email')?.hasError('email')
        ? 'validations.invalid_email'
        : '';
  }

  isError(): boolean {
    let isError =
      this.reactiveForm.get('oldPass')?.hasError('required')
      || this.reactiveForm.get('password')?.hasError('required');

    return isError ?? true;
  }

  save() {
    this.reactiveForm.markAllAsTouched();
    if (this.isError()) {
      return;
    }
    
    let oldPass = this.reactiveForm.controls['oldPass'].value;
    let password = this.reactiveForm.controls['password'].value;
    let changePassReqDto = new ChangePassReqDto();
    changePassReqDto.oldPass = oldPass;
    changePassReqDto.newPass = password;
    this.accountService.changeAccountPassword(this.editItem.id??'', changePassReqDto).subscribe(
      (response) => {
        this.dialogRef.close(true);
      },
      (error) => {
        console.log(error);
      },
      () => {

      }
    )
  }

  onClose(): void {
    this.dialogRef.close(false);
  }
}
