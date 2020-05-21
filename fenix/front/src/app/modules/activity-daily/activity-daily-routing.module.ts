import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ActivityDailyComponent } from './component/activity-daily.component';

const routes: Routes = [
  {
    path: '',
    component: ActivityDailyComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ActivityDailyRoutingModule { }
