import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { HappyMomentsComponent } from './happy-moments.component';

describe('HappyMomentsComponent', () => {
  let component: HappyMomentsComponent;
  let fixture: ComponentFixture<HappyMomentsComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ HappyMomentsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(HappyMomentsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
