import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { GoalsWeeklyComponent } from './goals-weekly.component';

describe('GoalsWeeklyComponent', () => {
  let component: GoalsWeeklyComponent;
  let fixture: ComponentFixture<GoalsWeeklyComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ GoalsWeeklyComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(GoalsWeeklyComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
