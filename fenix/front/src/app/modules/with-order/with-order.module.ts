import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { WithOrderRoutingModule } from './with-order-routing.module';
import { WithOrderComponent } from './component/with-order.component';
@NgModule({
  declarations: [
    WithOrderComponent
  ],
  imports: [
    CommonModule,
    WithOrderRoutingModule
  ],
  exports: [
    WithOrderComponent
  ]
})
export class WithOrderModule { }
