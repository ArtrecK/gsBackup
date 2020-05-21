import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ActivityDailyRoutingModule } from './activity-daily-routing.module';
import { ActivityDailyComponent } from './component/activity-daily.component';
@NgModule({
  declarations: [
    ActivityDailyComponent
  ],
  imports: [
    CommonModule,
    ActivityDailyRoutingModule
  ],
  exports: [
    ActivityDailyComponent
  ]
})
export class ActivityDailyModule { }
