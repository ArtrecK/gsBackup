import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { LayoutVendedorComponent } from './layout-vendedor.component';

describe('LayoutVendedorComponent', () => {
  let component: LayoutVendedorComponent;
  let fixture: ComponentFixture<LayoutVendedorComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ LayoutVendedorComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(LayoutVendedorComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
