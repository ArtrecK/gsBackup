import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { WithoutOrderComponent } from './component/without-order.component';

const routes: Routes = [
  {
    path: '',
    component: WithoutOrderComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class WithoutOrderRoutingModule { }
