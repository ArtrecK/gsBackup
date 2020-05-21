import { NgModule, ApplicationModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ContentVendedorRoutingModule } from './content-vendedor-routing.module';
import { ContentVendedorComponent } from './component/content-vendedor.component';
import { NavigationBarModule } from '../navigation-bar/navigation-bar.module';
import { BannersModule } from '../banners/banners.module';
import { GoalsModule } from '../goals/goals.module';
import { ClientsModule } from '../clients/clients.module';
import { OverviewModule } from '../overview/overview.module';


@NgModule({
  declarations: [ContentVendedorComponent],
  imports: [
    CommonModule,
    ContentVendedorRoutingModule,
    NavigationBarModule,
    BannersModule,
    GoalsModule,
    ClientsModule,
    OverviewModule
  ]
})
export class ContentVendedorModule { }
