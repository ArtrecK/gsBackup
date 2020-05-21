import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { OverviewPendingSupplyComponent } from './overview-pending-supply.component';

describe('OverviewPendingSupplyComponent', () => {
  let component: OverviewPendingSupplyComponent;
  let fixture: ComponentFixture<OverviewPendingSupplyComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ OverviewPendingSupplyComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(OverviewPendingSupplyComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
