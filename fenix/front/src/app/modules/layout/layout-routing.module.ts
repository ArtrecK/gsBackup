import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { LayoutVendedorComponent } from './layout-vendedor/layout-vendedor.component';
import { LayoutSupervisionComponent } from './layout-supervision/layout-supervision.component';
import { LayoutFichaClienteComponent } from './layout-ficha-cliente/layout-ficha-cliente.component';

const routes: Routes = [
  {
    path: '',
    redirectTo: '/main/0/0/0/0',
    pathMatch: 'full'
  },
  {
    path: '',
    component: LayoutVendedorComponent,
    children: [
      {
        path: 'main/:usuario/:sucursal/:terminal/:param1',
        loadChildren: '../content-vendedor/content-vendedor.module#ContentVendedorModule'
      }
    ]
  },
  {
    path: '',
    component: LayoutSupervisionComponent,
    children: [
      {
        path: 'mainGerente/:usuario/:sucursal/:terminal/:param1',
        loadChildren: '../content-gerente/content-gerente.module#ContentGerenteModule'
      },
      {
        path: 'mainRegional/:usuario/:region',
        loadChildren: '../content-regional/content-regional.module#ContentRegionalModule'
      },
      {
        path: 'mainZonal/:usuario/:zona',
        loadChildren: '../content-zonal/content-zonal.module#ContentZonalModule'
      },
      {
        path: 'mainNacional/:usuario/:pais',
        loadChildren: '../content-nacional/content-nacional.module#ContentNacionalModule'
      }
    ]
  },
  {
    path: '',
    component: LayoutFichaClienteComponent,
    children: [
      {
        path: 'fichaCliente',
        loadChildren: '../content-ficha-cliente/content-ficha-cliente.module#ContentFichaClienteModule'
      }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class LayoutRoutingModule { }
