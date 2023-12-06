import { Component, OnInit, Inject } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { DateAdapter } from '@angular/material/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { ActivatedRoute } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { CustomerDto } from 'app/dto/customer.dto';
import { CustomerService } from 'app/services/customer.service';
import { Subscription } from 'rxjs';

@Component({
  selector: 'page-customer-edit',
  templateUrl: './customer-edit.component.html',
  styleUrls: ['./customer-edit.component.scss'],
  providers: [CustomerService],
})
export class CustomerEditComponent implements OnInit {
  translateSubscription!: Subscription;
  reactiveForm: FormGroup;
  editItem: CustomerDto = new CustomerDto();
  editMode: boolean = false;

  constructor(
    private fb: FormBuilder,
    private dateAdapter: DateAdapter<any>,
    private translate: TranslateService,
    private route: ActivatedRoute,
    public dialogRef: MatDialogRef<CustomerEditComponent>,
    @Inject(MAT_DIALOG_DATA) public data: CustomerDto,

    private customerService: CustomerService,
  ) {

    this.editItem = data;
    this.editMode = Object.keys(this.editItem).length > 0 && !!this.editItem.id;

    this.reactiveForm = this.fb.group({
      fullName: [this.editItem.fullName, [Validators.required]],
      phoneNumber: [this.editItem.phoneNumber, [Validators.required]],
      address: [this.editItem.address, [Validators.required]],
    });

  }

  ngOnInit() {
    this.translateSubscription = this.translate.onLangChange.subscribe((res: { lang: any }) => {
      this.dateAdapter.setLocale(res.lang);
    });
  }

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

  isError() : boolean {
    let isError = this.reactiveForm.get('fullName')?.hasError('required')
    || this.reactiveForm.get('phoneNumber')?.hasError('required')
    || this.reactiveForm.get('address')?.hasError('required');

    return isError ?? true;
  }

  save() {
    this.reactiveForm.markAllAsTouched();
    if (this.isError()) {
      return;
    }

    let customerDto: CustomerDto = {
      fullName: this.reactiveForm.controls['fullName'].value,
      phoneNumber: this.reactiveForm.controls['phoneNumber'].value,
      address: this.reactiveForm.controls['address'].value,
    }
    // console.log(customerDto);

    var result;
    if (this.editMode) {
      result = this.customerService.update(this.editItem.id?? '', customerDto);
    } else {
      result = this.customerService.create(customerDto);
    }
    result.subscribe(
      (response) => {
        customerDto.id = response;
        this.dialogRef.close(customerDto);
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
