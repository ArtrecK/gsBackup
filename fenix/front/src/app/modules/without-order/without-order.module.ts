import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { WithoutOrderRoutingModule } from './without-order-routing.module';
import { WithoutOrderComponent } from './component/without-order.component';
@NgModule({
  declarations: [
    WithoutOrderComponent
  ],
  imports: [
    CommonModule,
    WithoutOrderRoutingModule
  ],
  exports: [
    WithoutOrderComponent
  ]
})
export class WithoutOrderModule { }
