import { Component, ElementRef, Inject, OnInit, ViewChild } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { DateAdapter } from '@angular/material/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { ActivatedRoute } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { AccountDto } from 'app/dto/account.dto';
import { SignupReqDto } from 'app/dto/signup-req.dto';
import { UpdateAccountInfoReqDto } from 'app/dto/update-account-info-req.dto';
import { AccountService } from 'app/services/account.service';
import { ImageService } from 'app/services/image.service';
import { Subscription } from 'rxjs';

@Component({
  selector: 'page-account-edit',
  templateUrl: './account-edit.component.html',
  styleUrls: ['./account-edit.component.scss'],
  providers: [AccountService],
})
export class AccountEditComponent implements OnInit {
  translateSubscription!: Subscription;
  reactiveForm: FormGroup;
  editItem: AccountDto = new AccountDto();
  editMode: boolean = false;
  avatar?: string;

  // "PRI_ADMIN", "ADMINISTRATOR_PRIVILEGE",
  // "PRI_SALE", "SALE_PRIVILEGE",
  // "PRI_FLORIST", "FLORIST_PRIVILEGE",
  // "PRI_SHIPPER", "SHIPPER_PRIVILEGE"
  lstRolesDto: any[] = [
    { value: 'FLORIST', name: 'Thợ' },
    { value: 'SHIPPER', name: 'Người giao hàng' },
    { value: 'SALE', name: 'Nhân viên sale' },
    { value: 'PROVINCIAL_ORDER_MANAGER', name: 'Nhân viên quản lý đơn tỉnh' },
    { value: 'DISPATCHERS', name: 'Nhân viên phân phối đơn cho shipper' },
    { value: 'SALE_ADMIN', name: 'Nhân viên sale admin' },
    { value: 'ADMIN', name: 'Admin' }
  ];

  constructor(
    private fb: FormBuilder,
    private dateAdapter: DateAdapter<any>,
    private translate: TranslateService,
    private route: ActivatedRoute,
    public dialogRef: MatDialogRef<AccountEditComponent>,
    @Inject(MAT_DIALOG_DATA) public data: AccountDto,

    private accountService: AccountService,
    private imageService: ImageService,
  ) {

    this.editItem = data;
    this.editMode = Object.keys(this.editItem).length > 0;

    this.reactiveForm = this.fb.group({
      username: [{ value: this.editItem.username, disabled: this.editMode }, [Validators.required]],
      roles: [this.editItem.roles, [Validators.required]],
      fullName: [this.editItem.fullName, [Validators.required]],
      phoneNumber: [this.editItem.phoneNumber, [Validators.required]],
    });

    // avatar.
    this.avatar = this.editItem.avatar;

  }

  ngOnInit() {
    this.translateSubscription = this.translate.onLangChange.subscribe((res: { lang: any }) => {
      this.dateAdapter.setLocale(res.lang);
    });
  }

  ngOnDestroy() {
    this.translateSubscription.unsubscribe();
  }


  @ViewChild('chooseFile') chooseFile?: ElementRef;
  onChooseFile(imgFile: any) {
    if (imgFile.target.files && imgFile.target.files[0]) {
      let file = imgFile.target.files[0];
      // Upload file.
      this.imageService.uploadAvatar(file).subscribe(
        (link) => {
          this.avatar = link;
        },
        (imageError) => {
          console.log(imageError);
        }
      );
    }
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
      this.reactiveForm.get('username')?.hasError('required')
      || this.reactiveForm.get('roles')?.hasError('required')
      || this.reactiveForm.get('fullName')?.hasError('required')
      || this.reactiveForm.get('phoneNumber')?.hasError('required');

    return isError ?? true;
  }

  save() {
    this.reactiveForm.markAllAsTouched();
    if (this.isError()) {
      return;
    }

    var result;
    if (this.editMode) {
      let updateAccountInfoReqDto: UpdateAccountInfoReqDto = {
        fullName: this.reactiveForm.controls['fullName'].value,
        phoneNumber: this.reactiveForm.controls['phoneNumber'].value,
        avatar: this.avatar,
        roles: this.reactiveForm.controls['roles'].value,
      }
      // Call service.
      result = this.accountService.update(this.editItem.id ?? '', updateAccountInfoReqDto);
    } else {
      let signupReqDto: SignupReqDto = {
        username: this.reactiveForm.controls['username'].value,
        password: '123456',
        roles: this.reactiveForm.controls['roles'].value,
        fullName: this.reactiveForm.controls['fullName'].value,
        phoneNumber: this.reactiveForm.controls['phoneNumber'].value,
        // avatar: this.avatar,
      }
      // Call service.
      result = this.accountService.create(signupReqDto);
    }
    result.subscribe(
      (response) => {
        this.dialogRef.close();
      },
      (error) => {
        console.log(error);
      },
      () => {

      }
    )
  }

  onClose(): void {
    this.dialogRef.close();
  }
}
