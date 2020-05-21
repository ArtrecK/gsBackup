import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { OverviewPromotionsComponent } from './overview-promotions.component';

describe('OverviewPromotionsComponent', () => {
  let component: OverviewPromotionsComponent;
  let fixture: ComponentFixture<OverviewPromotionsComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ OverviewPromotionsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(OverviewPromotionsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
