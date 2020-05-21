import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ContentVendedorComponent } from './component/content-vendedor.component';

const routes: Routes = [
  {
    path: '',
    component: ContentVendedorComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ContentVendedorRoutingModule { }
