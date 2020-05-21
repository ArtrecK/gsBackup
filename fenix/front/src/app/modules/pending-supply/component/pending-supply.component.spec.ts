import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { PendingSupplyComponent } from './pending-supply.component';

describe('PendingSupplyComponent', () => {
  let component: PendingSupplyComponent;
  let fixture: ComponentFixture<PendingSupplyComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ PendingSupplyComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PendingSupplyComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
