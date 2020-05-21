import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { WithOrderComponent } from './with-order.component';

describe('WithOrderComponent', () => {
  let component: WithOrderComponent;
  let fixture: ComponentFixture<WithOrderComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ WithOrderComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(WithOrderComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
