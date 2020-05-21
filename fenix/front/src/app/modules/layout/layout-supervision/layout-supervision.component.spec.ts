import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { LayoutSupervisionComponent } from './layout-supervision.component';

describe('LayoutSupervisionComponent', () => {
  let component: LayoutSupervisionComponent;
  let fixture: ComponentFixture<LayoutSupervisionComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ LayoutSupervisionComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(LayoutSupervisionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
