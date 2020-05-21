import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { LayoutFichaClienteComponent } from './layout-ficha-cliente.component';

describe('LayoutFichaClienteComponent', () => {
  let component: LayoutFichaClienteComponent;
  let fixture: ComponentFixture<LayoutFichaClienteComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ LayoutFichaClienteComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(LayoutFichaClienteComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
