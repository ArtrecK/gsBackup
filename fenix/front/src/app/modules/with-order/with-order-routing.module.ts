import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { WithOrderComponent } from './component/with-order.component';
const routes: Routes = [
  {
    path: '',
    component: WithOrderComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class WithOrderRoutingModule { }
