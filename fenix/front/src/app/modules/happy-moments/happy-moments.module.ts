import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { HappyMomentsComponent } from './component/happy-moments.component';

@NgModule({
  declarations: [HappyMomentsComponent],
  imports: [
    CommonModule
  ],
  exports: [HappyMomentsComponent]
})
export class HappyMomentsModule { }
