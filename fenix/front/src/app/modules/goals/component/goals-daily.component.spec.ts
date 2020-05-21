import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { GoalsDailyComponent } from './goals-daily.component';

describe('GoalsDailyComponent', () => {
  let component: GoalsDailyComponent;
  let fixture: ComponentFixture<GoalsDailyComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ GoalsDailyComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(GoalsDailyComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
