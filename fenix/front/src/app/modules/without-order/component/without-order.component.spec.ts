import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { WithoutOrderComponent } from './without-order.component';

describe('WithoutOrderComponent', () => {
  let component: WithoutOrderComponent;
  let fixture: ComponentFixture<WithoutOrderComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ WithoutOrderComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(WithoutOrderComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
