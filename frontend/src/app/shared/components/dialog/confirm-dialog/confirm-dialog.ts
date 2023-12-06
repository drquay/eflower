import { Component, Inject, Input } from "@angular/core";
import { MAT_DIALOG_DATA, MatDialogRef } from "@angular/material/dialog";

@Component({
    selector: 'confirm-dialog',
    templateUrl: 'confirm-dialog.html',
    styleUrls: ['confirm-dialog.scss'],
})
export class ConfirmDialogComponent {
    title: string = "Cảnh báo";
    message: string = "Bạn có muốn xóa?";
    confirmButtonText = "Đồng ý";
    cancelButtonText = "Đóng";
    constructor(
        @Inject(MAT_DIALOG_DATA) private data: any,
        private dialogRef: MatDialogRef<ConfirmDialogComponent>) {
        if (data) {
            this.message = data.message || this.message;
            if (data.buttonText) {
                this.confirmButtonText = data.buttonText.ok || this.confirmButtonText;
                this.cancelButtonText = data.buttonText.cancel || this.cancelButtonText;
            }
        }
    }

    onOkClick(): void {
        this.dialogRef.close(true);
    }

    onCancelClick(): void {
        this.dialogRef.close(false);
    }

}