import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { OverviewComponent } from './component/overview.component';
import { OverviewPendingSupplyComponent } from './component/overview-pending-supply/overview-pending-supply.component';
import { OverviewApplicationsComponent } from './component/overview-applications/overview-applications.component';
import { OverviewBudgetsComponent } from './component/overview-budgets/overview-budgets.component';
import { OverviewPromotionsComponent } from './component/overview-promotions/overview-promotions.component';
import { OverviewWithOrderComponent } from './component/overview-with-order/overview-with-order.component';
import { OverviewWithoutOrderComponent } from './component/overview-without-order/overview-without-order.component';

@NgModule({
  declarations: [
    OverviewComponent,
    OverviewPendingSupplyComponent,
    OverviewApplicationsComponent,
    OverviewBudgetsComponent,
    OverviewPromotionsComponent,
    OverviewWithOrderComponent,
    OverviewWithoutOrderComponent
  ],
  imports: [
    CommonModule
  ],
  exports: [
    OverviewComponent
  ]
})
export class OverviewModule { }
