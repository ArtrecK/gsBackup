import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PendingSupplyComponent } from './component/pending-supply.component';
const routes: Routes = [
  {
    path: '',
    component: PendingSupplyComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PendingSupplyRoutingModule { }
