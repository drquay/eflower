import { DecimalPipe, formatNumber, registerLocaleData } from '@angular/common';
import localeEn from '@angular/common/locales/en';
import localeVi from '@angular/common/locales/vi';
import { ChangeDetectorRef } from '@angular/core';
import { ViewChild } from '@angular/core';
import { ElementRef } from '@angular/core';
import { LOCALE_ID } from '@angular/core';
import { Component, OnInit, Inject } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { DateAdapter } from '@angular/material/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { ActivatedRoute } from '@angular/router';
import { SettingsService } from '@core';
import { UserService } from '@core/authentication/user.service';
import { environment } from '@env/environment';
import { MtxDialog } from '@ng-matero/extensions/dialog';
import { TranslateService } from '@ngx-translate/core';
import { ConfirmDialogComponent } from '@shared/components/dialog/confirm-dialog/confirm-dialog';
import { AccountResDto } from 'app/dto/account-res.dto';
import { AttachmentReqDto } from 'app/dto/attachment-req.dto';
import { AttachmentResDto } from 'app/dto/attachment-res.dto';
import { ShipperRouteForUpdateReq } from 'app/dto/shipper-route-for-update.req';
import { ShipperRouteRes } from 'app/dto/shipper-route.res';
import { AttachmentService } from 'app/services/attachment.service';
import { ImageService } from 'app/services/image.service';
import { ShipperRouteService } from 'app/services/shipper-route.service';
import { Subscription } from 'rxjs';

@Component({
  selector: 'page-shipper-route-edit',
  templateUrl: './shipper-route-edit.component.html',
  styleUrls: ['./shipper-route-edit.component.scss'],
  providers: [
    DecimalPipe,

    UserService,
    AttachmentService,
    ShipperRouteService,
  ],
})
export class ShipperRouteEditComponent implements OnInit {
  translateSubscription!: Subscription;
  thousandSeparator?: string;
  decimalMarker?: string;
  reactiveForm: FormGroup;
  editItem: ShipperRouteRes = new ShipperRouteRes();
  editMode: boolean = false;

  constructor(
    @Inject(LOCALE_ID) private locale: string,
    private fb: FormBuilder,
    private dateAdapter: DateAdapter<any>,
    private translate: TranslateService,
    public dialog: MtxDialog,
    public dialogRef: MatDialogRef<ShipperRouteEditComponent>,
    private settings: SettingsService,
    private route: ActivatedRoute,
    private decimalPipe: DecimalPipe,
    private cdr: ChangeDetectorRef,
    private snackBar: MatSnackBar,
    @Inject(MAT_DIALOG_DATA) public data: ShipperRouteRes,

    private userService: UserService,
    private shipperRouterService: ShipperRouteService,
  ) {
    this.registerLocale(this.settings.getLanguage());
    const [thousandSeparator, decimalMarker] = formatNumber(1000.99, 'currentLocale').replace(/\d/g, '');
    this.thousandSeparator = thousandSeparator;
    this.decimalMarker = decimalMarker;

    this.editItem = data;
    this.editMode = Object.keys(this.editItem).length > 0 && !!this.editItem.id;

    this.reactiveForm = this.fb.group({
      fromLongitude: [this.editItem.beginLongitude, [Validators.required]],
      fromLatitude: [this.editItem.beginLatitude, [Validators.required]],
      toLongitude: [this.editItem.endLongitude, [Validators.required]],
      toLatitude: [this.editItem.endLatitude, [Validators.required]],
      numberOfKm: [this.formatNumber(this.editItem.numberOfKm?.toString()), [Validators.required]],
    });

  }

  registerLocale(lang: string) {
    // console.log(this.locale);
    if (lang === 'vi-VN') {
      this.locale = 'vi';
      registerLocaleData(localeVi, 'currentLocale');
    } else {
      this.locale = 'en';
      registerLocaleData(localeEn, 'currentLocale');
    }
  }

  ngOnInit() {
    this.translateSubscription = this.translate.onLangChange.subscribe((res: { lang: any }) => {
      this.dateAdapter.setLocale(res.lang);
    });
  }

  ngOnDestroy() {
    this.translateSubscription.unsubscribe();
  }

  formatNumber(value?: string): string {
    if (!value) {
      return '';
    }
    return this.decimalPipe.transform(value, '1.0-3', 'currentLocale') ?? '';
  }

  unformatNumber(value?: string): string {
    if (!value) {
      return '';
    }
    const regExp = new RegExp(`[^\\d${this.decimalMarker}-]`, 'g');
    return value.replace(regExp, '');
  }

  onFocusNumber(event: any) {
    event.target.value = this.unformatNumber(event.target.value);
  }

  onBlurNumber(event: any) {
    event.target.value = this.formatNumber(event.target.value);
  }

  onChange(event: any) {
    // event.target.value = this.formatNumber(event.target.value);
  }

  getErrorMessage(form: FormGroup) {
    return form.get('email')?.hasError('required')
      ? 'validations.required'
      : form.get('email')?.hasError('email')
      ? 'validations.invalid_email'
      : '';
  }

  isError() : boolean {
    let isError = 
    this.reactiveForm.get('fromLongitude')?.hasError('required')
    || this.reactiveForm.get('fromLatitude')?.hasError('required')
    || this.reactiveForm.get('toLongitude')?.hasError('required')
    || this.reactiveForm.get('toLatitude')?.hasError('required')
    || this.reactiveForm.get('numberOfKm')?.hasError('required');

    return isError ?? true;
  }

  save() {
    this.reactiveForm.markAllAsTouched();
    if (this.isError()) {
      return;
    }

    let numberOfKm = Number.parseInt(this.unformatNumber(this.reactiveForm.controls['numberOfKm'].value));
    let shipperRouteForUpdateReq: ShipperRouteForUpdateReq = {
      fromLongitude: this.reactiveForm.controls['fromLongitude'].value,
      fromLatitude: this.reactiveForm.controls['fromLatitude'].value,
      toLongitude: this.reactiveForm.controls['toLongitude'].value,
      toLatitude: this.reactiveForm.controls['toLatitude'].value,
      numberOfKm: numberOfKm,
    }

    // console.log(shipperRouterDto);

    var result = this.shipperRouterService.update(this.editItem.id?? '', shipperRouteForUpdateReq);
    result.subscribe(
      (response) => {
        this.dialogRef.close();
      },
      (error) => {

      },
      () => {

      }
    )
  }

  onClose(): void {
    this.dialogRef.close();
  }
}
