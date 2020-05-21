import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { OverviewWithOrderComponent } from './overview-with-order.component';

describe('OverviewWithOrderComponent', () => {
  let component: OverviewWithOrderComponent;
  let fixture: ComponentFixture<OverviewWithOrderComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ OverviewWithOrderComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(OverviewWithOrderComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
