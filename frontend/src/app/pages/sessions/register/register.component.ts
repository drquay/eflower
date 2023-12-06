import { Component, OnInit } from '@angular/core';
import { FormBuilder, Validators, FormControl } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { SignupReqDto } from 'app/dto/signup-req.dto';
import { UpdateAccountInfoReqDto } from 'app/dto/update-account-info-req.dto';
import { AccountService } from 'app/services/account.service';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
})
export class RegisterComponent implements OnInit {

  confirmValidator = (control: FormControl): { [k: string]: boolean } => {
    if (!control.value) {
      return { error: true, required: true };
    } else if (control.value !== this.registerForm.controls.password.value) {
      return { error: true, confirm: true };
    }
    return {};
  };

  registerForm = this.fb.group({
    username: ['', [Validators.required]],
    password: ['', [Validators.required]],
    confirmPassword: ['', [this.confirmValidator]],
    fullName: ['', [Validators.required]],
    phoneNumber: ['', [Validators.required]],
  });

  constructor(
    private router: Router,
    private fb: FormBuilder,
    private accountService: AccountService,
  ) { }

  ngOnInit() { }

  save() {
    let accountDto = new SignupReqDto();
    accountDto.username = this.registerForm.controls.username.value;
    accountDto.password = this.registerForm.controls.password.value;
    accountDto.fullName = this.registerForm.controls.fullName.value;
    accountDto.phoneNumber = this.registerForm.controls.phoneNumber.value;
    this.accountService.create(accountDto).subscribe(
      (response) => {
        this.router.navigate(['/app-login']);
      },
      (error) => {

      }
    )
  }
}
