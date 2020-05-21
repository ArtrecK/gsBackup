import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { PendingSupplyRoutingModule } from './pending-supply-routing.module';
import { PendingSupplyComponent } from './component/pending-supply.component';
@NgModule({
  declarations: [
    PendingSupplyComponent
  ],
  imports: [
    CommonModule,
    PendingSupplyRoutingModule
  ],
  exports:[
    PendingSupplyComponent
  ]
})
export class PendingSupplyModule { }
