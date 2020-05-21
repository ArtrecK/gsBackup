import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { BannersRoutingModule } from './banners-routing.module';
import { BannersComponent } from './component/banners.component';
@NgModule({
  declarations: [
    BannersComponent
  ],
  imports: [
    CommonModule,
    BannersRoutingModule
  ],
  exports: [
    BannersComponent
  ]
})
export class BannersModule { }
