import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { GoalsRoutingModule } from './goals-routing.module';
import { GoalsComponent } from './component/goals.component';
import { GoalsDailyComponent } from './component/goals-daily.component';
import { GoalsWeeklyComponent } from './component/goals-weekly.component';

@NgModule({
  declarations: [
    GoalsComponent,
    GoalsDailyComponent,
    GoalsWeeklyComponent
  ],
  imports: [
    CommonModule,
    GoalsRoutingModule
  ],
  exports: [
    GoalsComponent
  ]
})
export class GoalsModule { }
