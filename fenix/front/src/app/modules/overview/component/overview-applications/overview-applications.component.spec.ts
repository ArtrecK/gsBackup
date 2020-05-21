import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { OverviewApplicationsComponent } from './overview-applications.component';

describe('OverviewApplicationsComponent', () => {
  let component: OverviewApplicationsComponent;
  let fixture: ComponentFixture<OverviewApplicationsComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ OverviewApplicationsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(OverviewApplicationsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
