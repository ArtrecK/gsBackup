import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { LayoutRoutingModule } from './layout-routing.module';

import { LayoutVendedorComponent } from './layout-vendedor/layout-vendedor.component';
import { LayoutSupervisionComponent } from './layout-supervision/layout-supervision.component';
import { LayoutFichaClienteComponent } from './layout-ficha-cliente/layout-ficha-cliente.component';

import { HeaderComponent } from './header/header.component';
import { FooterComponent } from './footer/footer.component';

import { ProfileVendedorComponent } from './profile-vendedor/profile-vendedor.component';
import { ProfileSupervisionComponent } from './profile-supervision/profile-supervision.component';

import { EmployeeModule } from '../employee/employee.module';
import { SearchModule } from '../search/search.module';
import { ActivityDailyModule } from '../activity-daily/activity-daily.module';
import { AlertsModule } from '../alerts/alerts.module';
import { HappyMomentsModule } from '../happy-moments/happy-moments.module';
import { ClockModule } from '../clock/clock.module';

@NgModule({
  declarations: [
    HeaderComponent,
    FooterComponent,
    LayoutVendedorComponent,
    LayoutSupervisionComponent,
    LayoutFichaClienteComponent,
    ProfileVendedorComponent,
    ProfileSupervisionComponent
  ],
  imports: [
    CommonModule,
    LayoutRoutingModule,
    EmployeeModule,
    SearchModule,
    ActivityDailyModule,
    AlertsModule,
    HappyMomentsModule,
    ClockModule
  ]
})
export class LayoutModule { }
