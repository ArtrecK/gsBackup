import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { OverviewWithoutOrderComponent } from './overview-without-order.component';

describe('OverviewWithoutOrderComponent', () => {
  let component: OverviewWithoutOrderComponent;
  let fixture: ComponentFixture<OverviewWithoutOrderComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ OverviewWithoutOrderComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(OverviewWithoutOrderComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
