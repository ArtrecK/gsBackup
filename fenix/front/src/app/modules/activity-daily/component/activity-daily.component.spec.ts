import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ActivityDailyComponent } from './activity-daily.component';

describe('ActivityDailyComponent', () => {
  let component: ActivityDailyComponent;
  let fixture: ComponentFixture<ActivityDailyComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ActivityDailyComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ActivityDailyComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
